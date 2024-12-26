output "cluster_id" {
  value = aws_eks_cluster.cloudgen.id
}

output "node_group_id" {
  value = aws_eks_node_group.cloudgen.id
}

output "vpc_id" {
  value = aws_vpc.cloudgen_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.cloudgen_subnet[*].id
}
