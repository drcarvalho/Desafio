#!/bin/bash

# Inicializa o minikube
minikube start

# Habilita o addon de ingress
minikube addons enable ingress

# Cria o namespace "monitoring"
kubectl create namespace monitoring

# Adiciona os repositórios do Helm do Prometheus e Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts

# Atualiza os repositórios do Helm
helm repo update

# Instala o Prometheus com o Helm
helm install prometheus prometheus-community/prometheus --namespace monitoring

# Instala o Grafana com o Helm
helm install grafana grafana/grafana --namespace monitoring

# Exibe a senha do admin do Grafana
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Encaminha a porta do serviço Grafana UI para o localhost
kubectl port-forward --namespace monitoring service/grafana 3000:80
