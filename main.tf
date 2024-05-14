provider "aws" {
  region = "us-east-1" 
}

resource "aws_instance" "example" {
  ami           = "ami-0bb84b8ffd87024d8"  # Amazon Linux 2023 AMI
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ec2-user
    sudo yum install -y conntrack
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-1.24.0.rpm
    sudo rpm -ivh minikube-1.24.0.rpm
    minikube start --driver=none
    EOF
}
