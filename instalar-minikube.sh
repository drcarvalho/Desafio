#!/bin/bash
               # Update and install necessary packages
               sudo apt-get update && sudo apt-get install -y curl apt-transport-https
               sudo apt-get install -y docker.io

               # Start Docker and enable on boot
               sudo systemctl start docker
               sudo systemctl enable docker

               # Install kubectl
               curl -LO "https://storage.googleapis.com/kubernetes-release/release/"
               # Install Minikube
               curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
               chmod +x minikube
               sudo mv minikube /usr/local/bin/
                sudo usermod -aG docker $USER && newgrp docker
               # Start Minikube
                minikube start --driver docker

                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                chmod +x kubectl
                sudo mv kubectl /usr/local/bin

