FROM python:3.7.4-slim

WORKDIR /app

COPY app/requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY app/api.py .

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "api:app"]
