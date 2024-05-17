#!/bin/bash

# Aplica o arquivo de manifesto para implantar os recursos no cluster
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/services.yaml
# Adicione mais comandos kubectl apply conforme necessário
