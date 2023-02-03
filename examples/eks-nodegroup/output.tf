#### output file ############

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.cluster_name
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks[*].cluster_id
}

/* output "codebuild_role_arn" {
  value       = module.codebuild_iam_role_eks[*].role_arn
  description = "The Amazon Resource Name (ARN) specifying the code build role"
}

output "eks-cloudwatch-dashboard-arn" {
  value       = module.eks_kubernetes_addons.eks-cloudwatch-dashboard-arn
  description = "The Amazon Resource Name (ARN) specifying the code build role"
} */

output "eks-kubeproxy-status" {
  value       = module.eks.kubeproxy-status
  description = "The kubeproxy-status "
}

# output "fluentbit-kms-json" {

#   description = "data.aws_iam_policy_document.kms.json"
#   value=module.eks_kubernetes_addons.kms-json
# }