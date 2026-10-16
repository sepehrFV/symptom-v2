"""Machine-learning engine: small neural-network ensemble trained on simulated cases.

Training distribution is class-BALANCED (every disease equally often), so rare
diseases are learned properly.  At inference time the model output is corrected
back to the real-world prior of the case (species x age x breed x audience) by
Bayes' rule:   P(c|x) ∝ P_model(c|x) / P_train(c|species) × P_prior(c|case)

Temperature scaling on a held-out simulated set calibrates the probabilities.
"""
from __future__ import annotations

import json
import time
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import joblib
import numpy as np
from sklearn.neural_network import MLPClassifier

from .kb import KnowledgeBase, NC_ID
from .rules import Context
from .simulator import Case, Simulator

MODEL_DIR = Path(__file__).resolve().parent.parent / "models"
MODEL_FILE = MODEL_DIR / "ml_model.joblib"


def featurize(kb: KnowledgeBase, species: str, audience: str, answers: Dict[str, str],
              age: Optional[str] = None) -> np.ndarray:
    n = len(kb.sign_ids)
    x = np.zeros(2 * n + len(kb.species_ids) + 2 + len(kb.age_ids), dtype=np.float32)
    for sid, a in answers.items():
        i = kb.sign_index.get(sid)
        if i is None:
            continue
        if a == "yes":
            x[i] = 1.0
        elif a == "no":
            x[n + i] = 1.0
    x[2 * n + kb.species_ids.index(species)] = 1.0
    x[2 * n + len(kb.species_ids) + (0 if audience == "owner" else 1)] = 1.0
    if age in kb.age_ids:     # unknown age -> all zeros
        x[2 * n + len(kb.species_ids) + 2 + kb.age_ids.index(age)] = 1.0
    return x


def featurize_cases(kb: KnowledgeBase, cases: List[Case], age_known_prob: float = 0.7,
                    seed: int = 0) -> Tuple[np.ndarray, np.ndarray]:
    rng = np.random.default_rng(seed)
    X = np.stack([featurize(kb, c.species, c.audience, c.answers,
                            c.age_group if rng.random() < age_known_prob else None) for c in cases])
    y = np.array([kb.class_index[c.label] for c in cases])
    return X, y


def _softmax(z):
    z = z - z.max(axis=1, keepdims=True)
    e = np.exp(z)
    return e / e.sum(axis=1, keepdims=True)


class MLEngine:
    def __init__(self, kb: KnowledgeBase, models: List[MLPClassifier], temperature: float,
                 train_species_prior: np.ndarray, meta: dict):
        self.kb = kb
        self.models = models
        self.temperature = temperature
        self.train_species_prior = train_species_prior   # (n_species, n_classes) P_train(c|species)
        self.meta = meta

    # ---------------------------------------------------------------- inference
    def _raw_proba(self, X: np.ndarray) -> np.ndarray:
        n_c = len(self.kb.classes)
        acc = np.zeros((X.shape[0], n_c))
        for m in self.models:
            pr = m.predict_proba(X)
            full = np.zeros((X.shape[0], n_c))
            full[:, m.classes_] = pr
            acc += full
        acc /= len(self.models)
        acc = np.clip(acc, 1e-9, 1.0)
        logits = np.log(acc) / self.temperature
        return _softmax(logits)

    def posterior_from_prior(self, ctx: Context, answers: Dict[str, str], prior: np.ndarray) -> np.ndarray:
        x = featurize(self.kb, ctx.species, ctx.audience, answers, ctx.age_group)[None, :]
        p = self._raw_proba(x)[0]
        sp = self.kb.species_ids.index(ctx.species)
        w = p / np.clip(self.train_species_prior[sp], 1e-9, None) * prior
        w[prior <= 0] = 0.0
        s = w.sum()
        return w / s if s > 0 else prior

    # ---------------------------------------------------------------- persistence
    def save(self, path: Path = MODEL_FILE):
        path.parent.mkdir(parents=True, exist_ok=True)
        joblib.dump({"models": self.models, "temperature": self.temperature,
                     "train_species_prior": self.train_species_prior, "meta": self.meta}, path, compress=3)

    @staticmethod
    def load(kb: KnowledgeBase, path: Path = MODEL_FILE) -> Optional["MLEngine"]:
        if not Path(path).exists():
            return None
        blob = joblib.load(path)
        if blob["meta"].get("kb_hash") != kb.hash:
            return None  # stale model: KB changed since training
        return MLEngine(kb, blob["models"], blob["temperature"], blob["train_species_prior"], blob["meta"])


def _fit_temperature(logp: np.ndarray, y: np.ndarray) -> float:
    best_t, best_nll = 1.0, 1e9
    for t in np.linspace(0.6, 2.5, 39):
        p = _softmax(logp / t)
        nll = -np.log(np.clip(p[np.arange(len(y)), y], 1e-12, 1)).mean()
        if nll < best_nll:
            best_t, best_nll = float(t), float(nll)
    return best_t


def train(kb: KnowledgeBase, verbose: bool = True, per_class: Optional[int] = None,
          ensemble: int = 3) -> MLEngine:
    cfg = kb.settings["ml"]
    per_class = per_class or cfg["samples_per_class"]
    t0 = time.time()
    sim = Simulator(kb, cfg["seed"])
    train_cases = sim.sample_dataset(per_class)
    val_sim = Simulator(kb, cfg["seed"] + 1)
    val_cases = val_sim.sample_dataset(cfg["holdout_per_class"])
    Xtr, ytr = featurize_cases(kb, train_cases)
    Xva, yva = featurize_cases(kb, val_cases)
    if verbose:
        print(f"[ml] simulated {len(train_cases)} train / {len(val_cases)} validation cases in {time.time()-t0:.0f}s")

    # P_train(class | species)
    cnt = np.zeros((len(kb.species_ids), len(kb.classes)))
    for c in train_cases:
        cnt[kb.species_ids.index(c.species), kb.class_index[c.label]] += 1
    cnt += 0.5
    tsp = cnt / cnt.sum(axis=1, keepdims=True)

    models = []
    for k in range(ensemble):
        m = MLPClassifier(hidden_layer_sizes=tuple(cfg["hidden_layers"]), activation="relu", alpha=2e-4,
                          batch_size=256, learning_rate_init=1e-3, max_iter=cfg["max_iter"],
                          early_stopping=True, validation_fraction=0.08, n_iter_no_change=6,
                          random_state=cfg["seed"] + 100 * k)
        m.fit(Xtr, ytr)
        models.append(m)
        if verbose:
            print(f"[ml] net {k+1}/{ensemble}: {m.n_iter_} epochs, val-acc {m.best_validation_score_:.3f}")

    tmp = MLEngine(kb, models, 1.0, tsp, {})
    raw = tmp._raw_proba(Xva)
    temp = _fit_temperature(np.log(np.clip(raw, 1e-12, 1)), yva)
    meta = {"kb_hash": kb.hash, "kb_version": kb.version, "per_class": per_class, "ensemble": ensemble,
            "temperature": temp, "trained_at": time.strftime("%Y-%m-%dT%H:%M:%S"), "seed": cfg["seed"],
            "classes": kb.classes}
    eng = MLEngine(kb, models, temp, tsp, meta)
    if verbose:
        print(f"[ml] temperature {temp:.2f}; total {time.time()-t0:.0f}s")
    return eng
