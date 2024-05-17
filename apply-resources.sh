#!/bin/bash

# Aplica o arquivo de manifesto no cluster
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/services.yaml

echo "Aguardando 30 segundos para o pod e o service iniciar..."
sleep 30

# Configura o redirecionamento de porta do service da aplicação para usar localhost 
kubectl port-forward service/services-desafio-globo 8000:80 &
