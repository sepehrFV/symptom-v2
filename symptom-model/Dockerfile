# Diagnosis engine (Flask). Build context: repository root (see docker-compose.yml).
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1
WORKDIR /app/symptom-model

COPY symptom-model/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY symptom-model/ .

# Train the AI engine at build time so the first request is fast (stale models are retrained automatically
# if the knowledge base is edited later; set AUTO_TRAIN=0 to disable that).
RUN python train.py

EXPOSE 5000
HEALTHCHECK --interval=15s --timeout=5s --start-period=20s CMD python -c "import urllib.request as u; u.urlopen('http://localhost:5000/health')"
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--timeout", "180", "app:app"]
