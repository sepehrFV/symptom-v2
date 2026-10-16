"""Regression tests for the KB and both engines.  Run:  python -m unittest discover -s tests -v"""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT))

import yaml  # noqa: E402

from engine.kb import NC_ID, load_kb  # noqa: E402
from engine.service import DiagnosisService  # noqa: E402

JAVA_ENUM = ROOT.parent / "symptom-service/src/main/java/msfv/original/enums/SymptomEnum.java"


def java_codes():
    if not JAVA_ENUM.exists():
        return set()
    return {int(m) for m in re.findall(r"\w+\(\(short\)\s*(\d+),", JAVA_ENUM.read_text(encoding="utf-8"))}


class KBLint(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.kb = load_kb()

    def test_sign_codes_exist_in_java_enum(self):
        codes = java_codes()
        if not codes:
            self.skipTest("Java enum not found")
        for s in self.kb.signs.values():
            for c in s.codes:
                self.assertIn(c, codes, f"sign {s.id}: legacy code {c} not in SymptomEnum")

    def test_priors_sum_to_one(self):
        for sp in self.kb.species_ids:
            for aud in self.kb.settings["audiences"]:
                for age in self.kb.age_ids + [None]:
                    pr = self.kb.priors(sp, age, None, aud)
                    self.assertAlmostEqual(sum(pr.values()), 1.0, places=6)

    def test_parent_prob_at_least_children(self):
        for d in self.kb.diseases.values():
            for sp in self.kb.species_ids:
                for s in self.kb.signs.values():
                    for c in s.children:
                        self.assertGreaterEqual(d.p[sp][s.id] + 1e-9, d.p[sp][c], f"{d.id}/{sp}: {s.id} < child {c}")

    def test_probabilities_in_range(self):
        for d in self.kb.diseases.values():
            for sp in self.kb.species_ids:
                for v in d.p[sp].values():
                    self.assertTrue(0 < v < 1)

    def test_every_disease_has_refs_and_known_status(self):
        refs = set(self.kb.references)
        for d in self.kb.diseases.values():
            self.assertTrue(d.refs, f"{d.id} has no references")
            for r in d.refs:
                self.assertIn(r, refs, f"{d.id}: unknown ref {r}")
            self.assertTrue(d.status)

    def test_db_names_unique(self):
        seen = {}
        for d in self.kb.diseases.values():
            for n in d.db_names:
                self.assertNotIn(n, seen, f"db_name {n} used by {d.id} and {seen.get(n)}")
                seen[n] = d.id

    def test_red_flags_have_urgency_and_text(self):
        for s in self.kb.signs.values():
            if s.red_flag:
                self.assertIn(s.red_flag["urgency"], ("urgent", "emergency"))
                self.assertTrue(s.red_flag.get("fa") and s.red_flag.get("en"))

    def test_persian_text_present(self):
        for s in self.kb.signs.values():
            self.assertTrue(s.fa and s.ask_fa, s.id)
        for d in self.kb.diseases.values():
            self.assertTrue(d.name_fa, d.id)


class ServiceBehaviour(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.svc = DiagnosisService(load_ml=True)

    def dx(self, **kw):
        req = {"species": "dog", "age_group": "senior", "breed_group": "unknown", "audience": "owner",
               "answers": {}, "mode": "combined"}
        req.update(kw)
        return self.svc.diagnose(req)

    def test_empty_request_returns_question_and_prior_ranking(self):
        r = self.dx()
        self.assertIsNotNone(r["next_question"])
        self.assertFalse(r["status"]["done"])

    def test_owner_never_asked_exam_or_test_signs(self):
        r = self.dx(answers={"cough": "yes", "exercise_intolerance": "yes"})
        q = r["next_question"]
        self.assertIn(q["level"], ("owner", "history"))

    def test_unknown_answers_do_not_change_ranking(self):
        a = self.dx(mode="rule", answers={"cough": "yes"})
        b = self.dx(mode="rule", answers={"cough": "yes", "syncope": "unknown"})
        self.assertEqual([x["id"] for x in a["ranking"]], [x["id"] for x in b["ranking"]])

    def test_classic_mmvd_dog(self):
        r = self.dx(breed_group="cavalier", audience="clinician", mode="rule",
                    answers={"heart_murmur": "yes", "murmur_left_apical_systolic": "yes",
                             "cough": "yes", "tachypnea_resting": "yes"})
        self.assertEqual(r["ranking"][0]["id"], "mmvd")

    def test_emergency_triage_for_cyanosis(self):
        r = self.dx(answers={"cyanosis": "yes", "dyspnea": "yes"})
        self.assertEqual(r["triage"]["level"], "emergency")

    def test_species_specific_hcm_cat(self):
        r = self.dx(species="cat", age_group="adult", audience="clinician", mode="rule",
                    answers={"gallop_rhythm": "yes", "heart_murmur": "yes", "open_mouth_breathing": "yes"})
        top3 = [x["id"] for x in r["ranking"][:3]]
        self.assertTrue({"hcm", "rcm_unclassified", "thyrotoxic_cm", "hypertensive_hd"} & set(top3))

    def test_rejects_bad_input(self):
        with self.assertRaises(ValueError):
            self.dx(species="horse")
        r = self.dx(answers={"not_a_sign": "yes"})
        self.assertIn("unknown_signs", [w["code"] for w in r["warnings"]])

    def test_modes(self):
        for m in ("rule", "ai", "combined"):
            r = self.dx(mode=m, answers={"cough": "yes"})
            self.assertEqual(r["engine_used"], m)

    def test_ranking_has_no_fake_percentages(self):
        r = self.dx(answers={"cough": "yes"})
        for it in r["ranking"]:
            self.assertIn(it["band"], ("high", "moderate", "low", "unlikely"))
        self.assertIn(r["cardiac_likelihood"]["band"], ("high", "moderate", "low", "very_low"))

    def test_probabilities_normalised(self):
        r = self.dx(answers={"cough": "yes", "syncope": "no"}, top_k=40)
        self.assertAlmostEqual(sum(x["absolute_probability"] for x in r["ranking"]) + r["non_cardiac"]["probability"], 1.0, places=2)

    def test_disclaimers(self):
        r = self.dx()
        self.assertTrue(r["disclaimer_fa"] and r["disclaimer_en"])


class Vignettes(unittest.TestCase):
    def test_combined_engine_passes_vignettes(self):
        import evaluate
        svc = DiagnosisService(load_ml=True)
        res = evaluate.run_vignettes(svc)
        comb = res["modes"]["combined"]
        self.assertGreaterEqual(comb["rate"], 0.95, [r for r in comb["results"] if not r["pass"]])


if __name__ == "__main__":
    unittest.main()
