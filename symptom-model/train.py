"""Train (or retrain) the ML engine from the knowledge base:  python train.py"""
import json
import sys

from engine.kb import load_kb
from engine.ml import MODEL_FILE, train

if __name__ == "__main__":
    kb = load_kb()
    quick = "--quick" in sys.argv
    eng = train(kb, per_class=400 if quick else None, ensemble=1 if quick else 3)
    eng.save(MODEL_FILE)
    print("saved", MODEL_FILE, json.dumps({k: v for k, v in eng.meta.items() if k != "classes"}))
