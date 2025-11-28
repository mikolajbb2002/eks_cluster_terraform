resource "aws_eks_node_group" "example" {
  cluster_name    = var.cluster_name
  node_group_name = var.aws_eks_node_group
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = aws_subnet.example[*].id

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  instance_types = [var.node_instance_type]
  ami_type       = var.node_ami_type
  disk_size      = var.node_disk_size

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_subnet" "example" {
  count = var.number_of_subnets
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.subnet_cidrs[count.index]
  vpc_id            = var.vpc_id
}
