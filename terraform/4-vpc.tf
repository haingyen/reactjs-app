# VPC ---------------------------------------------------------------------------------------------
resource "aws_vpc" "vpc_swarm_cluster" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "vpc_swarm_cluster"
  }
}