resource "aws_eks_cluster" "main" {
  name = var.aws_eks_cluster_name

role_arn = aws_iam_role.eks_cluster.arn

vpc_config {
    subnet_ids = module.network.public_subnet_ids
}

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}