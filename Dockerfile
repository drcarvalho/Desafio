# Usa a imagem base do Python 3.7.4 slim
FROM python:3.7.4-slim

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia e instala as dependências Python
COPY app/requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copia a aplicação para o diretório de trabalho
COPY app/api.py .

# Comandos para iniciar o server
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "api:app"]
