# SUBNETS -----------------------------------------------------------------------------------------
resource "aws_subnet" "subnet_for_manager_node" {
  vpc_id = aws_vpc.vpc_swarm_cluster.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_for_manager_node"
  }
}

resource "aws_subnet" "subnet_for_jenkins_node" {
  vpc_id = aws_vpc.vpc_swarm_cluster.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_for_jenkins_node"
  }
}

resource "aws_subnet" "subnet_for_worker_nodes" {
  count             = 2
  vpc_id            = aws_vpc.vpc_swarm_cluster.id
  cidr_block        = element(["10.0.8.0/24", "10.0.12.0/24"], count.index)
  availability_zone = element(["ap-southeast-1a", "ap-southeast-1b"], count.index)
  map_public_ip_on_launch = true 

  tags = {
    Name = "subnet_for_worker_node-${count.index + 1}"
  }
}