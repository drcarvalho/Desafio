provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "cluster-desafio-globo" {
  name     = "cluster-desafio-globo"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.29"  # versão do Kubernetes

  vpc_config {
    subnet_ids = ["subnet-06ddeda2b2a8aa0e9", "subnet-0667d0fa7c46dd7e9"]  # IDs das subnets onde o cluster será provisionado
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_attachment]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name = "eks-cluster-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:Describe*",
          "ec2:CreateSecurityGroup",
          "ec2:CreateTags",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateRouteTable",
          "ec2:CreateInternetGateway",
          "ec2:CreateVpc",
          "ec2:CreateSubnet",
          "ec2:DeleteRoute",
          "ec2:CreateRoute",
          "ec2:DeleteRouteTable",
          "ec2:DeleteInternetGateway",
          "ec2:DeleteSubnet",
          "ec2:DeleteVpc",
          "ec2:DeleteSecurityGroup",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeRouteTables",
          "eks:CreateCluster",
          "eks:DeleteCluster",
          "eks:DescribeCluster",
          "eks:UpdateClusterVersion",
          "eks:DescribeUpdate",
          "eks:UpdateClusterConfig",
          "eks:ListClusters",
          "eks:ListUpdates",
          "eks:TagResource",
          "eks:UntagResource",
          "eks:ListTagsForResource",
          "eks:AssociateEncryptionConfig",
          "eks:ListFargateProfiles",
          "eks:CreateFargateProfile",
          "eks:DeleteFargateProfile"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster-desafio-globo.name
  node_group_name = "node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = ["subnet-06ddeda2b2a8aa0e9", "subnet-0667d0fa7c46dd7e9"]  # IDs das subnets onde os nodes serão provisionados

  scaling_config {
    min_size = 2
    max_size = 2
    desired_size = 2
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}
