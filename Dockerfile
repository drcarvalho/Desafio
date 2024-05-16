# Usa a imagem base do Python 3.7.4 slim
FROM python:3.7.4-slim

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia e instala as dependências Python
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia a aplicação para o diretório de trabalho
COPY app/api.py .

# Comandos para iniciar o server
CMD ["gunicorn", "--log-level", "debug", "--bind", "0.0.0.0:8000", "api:app"]
