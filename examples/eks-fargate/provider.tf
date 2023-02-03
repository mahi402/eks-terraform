

data "aws_eks_cluster" "eks-cluster" {
  name = module.eks-fargate.cluster_id

}

provider "kubernetes" {

  host                   = module.eks-fargate.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks-fargate.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks-fargate.cluster_id, "--region", var.aws_region, "--role-arn", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.terraformassumerole}"]
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks-fargate.cluster_id, "--region", var.aws_region, "--role-arn", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.terraformassumerole}"]
    }
  }

}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = module.eks-fargate.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks-fargate.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks-fargate.cluster_id, "--region", var.aws_region, "--role-arn", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.terraformassumerole}"]
  }
  load_config_file = false
}

