output "subnet_ids_for_worker_nodes" {
  value = aws_subnet.subnet_for_worker_nodes[*].id
}
