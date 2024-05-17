#!/bin/bash

# Inicializa o minikube
minikube start

# Habilita o addon de ingress
minikube addons enable ingress

# Verifica se o minikube está funcionando corretamente
kubectl get pods --all-namespaces

# Adiciona o repositório do Helm do Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Cria o namespace "loki"
kubectl create namespace loki-stack

# Cria um arquivo yaml para configurar o loki
cat <<EOF > loki-stack-values.yaml
loki:
  enabled: true
  size: 1Gi
promtail:
  enabled: true
grafana:
  enabled: true
  sidecar:
    datasources:
      enabled: true
EOF

# Instala o Loki Stack com o Helm
helm upgrade --install loki --namespace=loki-stack grafana/loki-stack --values loki-stack-values.yaml --create-namespace

# Cria um arquivo yaml para configurar o grafana
cat <<EOF > grafana-agent-values.yaml
agent:
  mode: 'flow'
  configMap:
    create: true
    content: |
      logging {
        level  = "info"
        format = "logfmt"
      }

      loki.source.kubernetes_events "events" {
        log_format = "json"
        forward_to = [loki.write.loki_endpoint.receiver]
      }

      loki.write "loki_endpoint" {
        endpoint {
          url = "http://loki.loki-stack:3100/loki/api/v1/push"
        }
      }
EOF

# Instala o Grafana-Agent com o Helm
helm upgrade --install grafana-agent --namespace=loki-stack grafana/grafana-agent --values grafana-agent-values.yaml

# Direciona porta do serviço Grafana UI para o localhost
kubectl port-forward svc/loki-grafana 3000:80 -n loki-stack &

# Exibe a senha do admin do Grafana (importante salvar)
kubectl get secret loki-grafana -n loki-stack -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
