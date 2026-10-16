"""Knowledge-base loader / validator.

The KB (YAML files in ../kb) is the single source of truth for both engines:
the transparent Bayesian rule engine and the machine-learning model that is
trained on cases simulated from the very same KB.
"""
from __future__ import annotations

import hashlib
import math
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional

import yaml

KB_DIR = Path(__file__).resolve().parent.parent / "kb"
NC_ID = "non_cardiac"  # id of the "other cause" hypothesis

_P_MIN, _P_MAX = 0.002, 0.985


def _clip(p: float) -> float:
    return min(_P_MAX, max(_P_MIN, p))


@dataclass
class Sign:
    id: str
    level: str
    group: str
    leak: float
    en: str
    fa: str
    ask_en: str
    ask_fa: str
    hint_fa: str = ""
    ask_clinician_en: str = ""
    ask_clinician_fa: str = ""
    parent: Optional[str] = None
    codes: List[int] = field(default_factory=list)
    red_flag: Optional[dict] = None
    children: List[str] = field(default_factory=list)


@dataclass
class Disease:
    id: str
    name_en: str
    name_fa: str
    category: str
    db_names: List[str]
    urgency: str
    status: str
    prior: Dict[str, float]
    age: Dict[str, float]
    breed: Dict[str, Dict[str, float]]
    stage_weights: Dict[str, float]
    p: Dict[str, Dict[str, float]]          # species -> sign -> P(sign | disease)
    listed: Dict[str, set]                  # species -> signs explicitly graded
    confirm_en: List[str]
    note_en: str
    refs: List[str]


class KnowledgeBase:
    def __init__(self, kb_dir: Path = KB_DIR):
        self.dir = Path(kb_dir)
        load = lambda n: yaml.safe_load((self.dir / n).read_text(encoding="utf-8"))
        self.settings = load("settings.yaml")
        raw_signs = load("signs.yaml")["signs"]
        raw_dis = load("diseases.yaml")["diseases"]
        raw_nc = load("non_cardiac.yaml")["profiles"]
        self.references = load("references.yaml")["references"]
        self.version = self.settings["kb_version"]
        self.hash = hashlib.sha256(
            b"".join((self.dir / n).read_bytes() for n in
                     ["settings.yaml", "signs.yaml", "diseases.yaml", "non_cardiac.yaml"])
        ).hexdigest()[:16]

        self.grades: Dict[str, float] = self.settings["grades"]
        self.observation = self.settings["observation"]
        self.cost = self.settings["question_cost"]
        self.decision = self.settings["decision"]
        self.species_ids = list(self.settings["species"].keys())
        self.age_ids = list(self.settings["age_groups"].keys())
        self.breed_groups = self.settings["breed_groups"]

        # ---- signs ------------------------------------------------------------
        self.signs: Dict[str, Sign] = {}
        for s in raw_signs:
            sg = Sign(
                id=s["id"], level=s["level"], group=s["group"], leak=float(s["leak"]),
                en=s["en"], fa=s["fa"], ask_en=s["ask_en"], ask_fa=s["ask_fa"],
                hint_fa=s.get("hint_fa", ""), ask_clinician_en=s.get("ask_clinician_en", ""),
                ask_clinician_fa=s.get("ask_clinician_fa", ""), parent=s.get("parent"),
                codes=s.get("codes", []) or [], red_flag=s.get("red_flag"),
            )
            if sg.id in self.signs:
                raise ValueError(f"duplicate sign id {sg.id}")
            self.signs[sg.id] = sg
        for sg in self.signs.values():
            if sg.parent:
                if sg.parent not in self.signs:
                    raise ValueError(f"sign {sg.id}: unknown parent {sg.parent}")
                self.signs[sg.parent].children.append(sg.id)
        self.sign_ids: List[str] = list(self.signs.keys())          # stable feature order
        self.sign_index = {s: i for i, s in enumerate(self.sign_ids)}

        # ---- diseases ---------------------------------------------------------
        self.diseases: Dict[str, Disease] = {}
        age_pop = {a: v["population"] for a, v in self.settings["age_groups"].items()}
        for d in raw_dis:
            self.diseases[d["id"]] = self._build_disease(d, age_pop)
        self.disease_ids: List[str] = list(self.diseases.keys())

        # ---- non-cardiac mixture ---------------------------------------------------
        self.nc_profiles = []
        for pr in raw_nc:
            self.nc_profiles.append({
                "id": pr["id"], "name_en": pr["name_en"], "name_fa": pr["name_fa"],
                "weight": pr["weight"], "age": pr.get("age") or {},
                "p": {sg: self._grade(g) for sg, g in (pr.get("signs") or {}).items()},
            })
        self.nc_leak = {"owner": 0.02, "history": 0.03, "exam": 0.02, "test": 0.01}
        for pr in self.nc_profiles:
            pr["age_norm"] = self._norm_age(pr["age"], age_pop)
        # nc_p[(species, age_or_None)][sign]; profile weights depend on species and age
        self.nc_p: Dict[tuple, Dict[str, float]] = {}
        for sp in self.species_ids:
            for age in self.age_ids + [None]:
                ws = self.nc_profile_weights(sp, age)
                vec = {}
                for sid, sg in self.signs.items():
                    v = sum(w * p["p"].get(sid, self.nc_leak[sg.level]) for w, p in zip(ws, self.nc_profiles))
                    vec[sid] = _clip(v)
                for sid, sg in self.signs.items():
                    if sg.children:
                        vec[sid] = max(vec[sid], max(vec[c] for c in sg.children))
                self.nc_p[(sp, age)] = vec

        # hypotheses (cardiac diseases first, then the non-cardiac class)
        self.classes: List[str] = self.disease_ids + [NC_ID]
        self.class_index = {c: i for i, c in enumerate(self.classes)}

        # ---- demographic multipliers normalised to population mean 1 ------------------
        self._age_mult = {d: self._norm_age(self.diseases[d].age, age_pop) for d in self.disease_ids}
        self._breed_mult = {}
        for d in self.disease_ids:
            for sp in self.species_ids:
                pop = {b: v["population"] for b, v in self.breed_groups[sp].items() if b != "unknown"}
                self._breed_mult[(d, sp)] = self._norm_breed(self.diseases[d].breed.get(sp, {}), pop)

    # ------------------------------------------------------------------ helpers
    def _grade(self, g) -> float:
        if isinstance(g, (int, float)):
            return _clip(float(g))
        if g not in self.grades:
            raise ValueError(f"unknown grade {g!r}")
        return _clip(self.grades[g])

    @staticmethod
    def _norm_age(mult: Dict[str, float], pop: Dict[str, float]) -> Dict[str, float]:
        m = {a: float(mult.get(a, 1.0)) for a in pop}
        e = sum(pop[a] * m[a] for a in pop)
        return {a: (m[a] / e if e > 0 else 1.0) for a in m}

    @staticmethod
    def _norm_breed(mult: Dict[str, float], pop: Dict[str, float]) -> Dict[str, float]:
        m = {b: float(mult.get(b, 1.0)) for b in pop}
        e = sum(pop[b] * m[b] for b in pop)
        out = {b: (m[b] / e if e > 0 else 1.0) for b in m}
        out["unknown"] = 1.0
        return out

    def _build_disease(self, d: dict, age_pop) -> Disease:
        for need in ("id", "name_en", "name_fa", "prior", "signs"):
            if need not in d:
                raise ValueError(f"disease missing {need}: {d.get('id')}")
        base = d["signs"] or {}
        p: Dict[str, Dict[str, float]] = {}
        listed: Dict[str, set] = {}
        for sp in self.species_ids:
            over = d.get(f"signs_{sp}") or {}
            merged = {**base, **over}
            for sid in merged:
                if sid not in self.signs:
                    raise ValueError(f"{d['id']}: unknown sign '{sid}'")
            p[sp] = {}
            for sid, sg in self.signs.items():
                p[sp][sid] = self._grade(merged[sid]) if sid in merged else _clip(sg.leak)
            # parent >= max(children) so a murmur location implies a murmur
            for sid, sg in self.signs.items():
                if sg.children:
                    child_max = max(p[sp][c] for c in sg.children)
                    if sid not in merged:
                        p[sp][sid] = max(p[sp][sid], child_max)
            listed[sp] = set(merged)
        sw = d.get("stage_weights") or self.settings["default_stage_weights"]
        tot = sum(sw.values())
        sw = {k: v / tot for k, v in sw.items()}
        return Disease(
            id=d["id"], name_en=d["name_en"], name_fa=d["name_fa"], category=d.get("category", ""),
            db_names=[n.lower() for n in (d.get("db_names") or [])], urgency=d.get("urgency", "routine"),
            status=d.get("status", "draft_ai_pending_vet_review"),
            prior={sp: float((d["prior"] or {}).get(sp, 0.0)) for sp in self.species_ids},
            age={a: float(v) for a, v in (d.get("age") or {}).items()},
            breed={sp: (d.get("breed") or {}).get(sp, {}) for sp in self.species_ids},
            stage_weights=sw, p=p, listed=listed, confirm_en=d.get("confirm_en") or [],
            note_en=d.get("note_en", ""), refs=d.get("refs") or [],
        )

    def nc_profile_weights(self, species: str, age: Optional[str]) -> List[float]:
        """normalised mixture weights of the non-cardiac profiles for species / age"""
        w = []
        for p in self.nc_profiles:
            base = p["weight"].get(species, 0.0)
            w.append(base * (p["age_norm"].get(age, 1.0) if age in self.age_ids else 1.0))
        tot = sum(w)
        return [x / tot for x in w]

    # ------------------------------------------------------------------ public API
    def p_true(self, cls: str, species: str, sign: str, age: Optional[str] = None) -> float:
        """P(sign truly present | class) for the species (age matters only for the non-cardiac mixture)."""
        if cls == NC_ID:
            return self.nc_p[(species, age if age in self.age_ids else None)][sign]
        return self.diseases[cls].p[species][sign]

    def p_reported(self, cls: str, species: str, sign: str, age: Optional[str] = None) -> float:
        """P(user answers 'yes' | class): true probability blurred by observer error."""
        return self.blur(self.p_true(cls, species, sign, age), self.signs[sign].level)

    def blur(self, p: float, level: str) -> float:
        o = self.observation[level]
        return p * (1.0 - o["miss"]) + (1.0 - p) * o["false_pos"]

    def priors(self, species: str, age: Optional[str], breed: Optional[str], audience: str) -> Dict[str, float]:
        """Prior over all classes (sums to 1)."""
        pnc = float(self.settings["audiences"][audience]["non_cardiac_prior"])
        raw = {}
        for d in self.disease_ids:
            dis = self.diseases[d]
            w = dis.prior.get(species, 0.0)
            if w <= 0:
                raw[d] = 0.0
                continue
            a = self._age_mult[d].get(age, 1.0) if age in self.age_ids else 1.0
            b = self._breed_mult[(d, species)].get(breed, 1.0) if breed else 1.0
            raw[d] = w * a * b
        tot = sum(raw.values())
        out = {d: (1.0 - pnc) * v / tot for d, v in raw.items()}
        out[NC_ID] = pnc
        return out

    def validate_context(self, species: str, age: Optional[str], breed: Optional[str]):
        if species not in self.species_ids:
            raise ValueError(f"species must be one of {self.species_ids}")
        if age is not None and age not in self.age_ids:
            raise ValueError(f"age_group must be one of {self.age_ids}")
        if breed is not None and breed not in self.breed_groups[species]:
            raise ValueError(f"breed_group for {species} must be one of {list(self.breed_groups[species])}")

    def allowed_levels(self, audience: str) -> List[str]:
        return self.settings["audiences"][audience]["levels"]

    def disease_by_db_name(self) -> Dict[str, str]:
        m = {}
        for d in self.diseases.values():
            for n in d.db_names:
                m[n] = d.id
        return m


_cache: Dict[str, KnowledgeBase] = {}


def load_kb(kb_dir: Path = KB_DIR) -> KnowledgeBase:
    key = str(kb_dir)
    if key not in _cache:
        _cache[key] = KnowledgeBase(Path(kb_dir))
    return _cache[key]


def entropy_bits(p) -> float:
    return -sum(x * math.log2(x) for x in p if x > 1e-12)
