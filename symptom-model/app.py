"""Flask API of the diagnosis engine.

GET  /health
GET  /meta                         species, age groups, breed groups, audiences, disclaimers
GET  /signs?audience=owner|clinician
GET  /diseases                     KB disease overview (ids, names, legacy DB names)
POST /diagnose                     {species, age_group, breed_group, audience, answers{sign:yes|no|unknown},
                                    mode: combined|rule|ai, top_k, initial[]}
"""
import logging
import os

from flask import Flask, jsonify, request

from engine.ml import MODEL_FILE, train
from engine.service import DiagnosisService

log = logging.getLogger("diagnosis")
logging.basicConfig(level=logging.INFO)

app = Flask(__name__)
app.json.ensure_ascii = False
_service = None


def service() -> DiagnosisService:
    global _service
    if _service is None:
        svc = DiagnosisService()
        if svc.ml is None and os.getenv("AUTO_TRAIN", "1") == "1":
            log.warning("No (valid) ML model found - training now (one-off, ~2-3 min)")
            eng = train(svc.kb, verbose=True)
            eng.save(MODEL_FILE)
            svc.ml = eng
        _service = svc
    return _service


@app.get("/health")
def health():
    s = service()
    return jsonify({"status": "ok", "kb_version": s.kb.version, "kb_hash": s.kb.hash, "ml_loaded": s.ml is not None})


@app.get("/meta")
def meta():
    return jsonify(service().meta())


@app.get("/signs")
def signs():
    return jsonify(service().signs_for((request.args.get("audience") or "owner").lower()))


@app.get("/diseases")
def diseases():
    return jsonify(service().diseases_overview())


@app.post("/diagnose")
def diagnose():
    body = request.get_json(silent=True)
    if not isinstance(body, dict):
        return jsonify({"error": "JSON body required"}), 400
    try:
        return jsonify(service().diagnose(body))
    except ValueError as e:
        return jsonify({"error": str(e)}), 400
    except Exception as e:  # noqa
        log.exception("diagnose failed")
        return jsonify({"error": "internal error", "detail": str(e)}), 500


if __name__ == "__main__":
    service()
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "5000")))
