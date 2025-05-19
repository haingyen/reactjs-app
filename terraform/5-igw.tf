# IGW ---------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_swarm_cluster.id

  tags = {
    Name = "igw_swarm_cluster"
  }
}