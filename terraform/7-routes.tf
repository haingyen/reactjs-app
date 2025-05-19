# ROUTES TABLES -----------------------------------------------------------------------------------
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc_swarm_cluster.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rtb"
  }
}

resource "aws_route_table_association" "rt_for_manager_node" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id = aws_subnet.subnet_for_manager_node.id
}

resource "aws_route_table_association" "rt_for_jenkins_node" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id = aws_subnet.subnet_for_jenkins_node.id
}

resource "aws_route_table_association" "rt_for_worker_nodes" {
  count = length(aws_subnet.subnet_for_worker_nodes)
  route_table_id = aws_route_table.public_rtb.id
  subnet_id = aws_subnet.subnet_for_worker_nodes[count.index].id
}