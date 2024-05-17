#!/bin/bash

# Inicializa o minikube
minikube start

# Habilita o addon de ingress
minikube addons enable ingress

# Adiciona os repositórios do Helm do Prometheus e Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts

# Atualiza os repositórios do Helm
helm repo update

# Instala o Prometheus com o Helm
helm install prometheus prometheus-community/prometheus 

# Instala o Grafana com o Helm no kubernetes 
helm install grafana grafana/grafana 

# Exibe a senha do admin do Grafana (importante salvar)
kubectl get secret grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Direciona porta do serviço Grafana UI para o localhost
kubectl port-forward service/grafana 3000:80
