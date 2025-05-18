# VPC ---------------------------------------------------------------------------------------------
resource "aws_vpc" "vpc_swarm_cluster" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_swarm_cluster"
  }
}

# INTERNET GATEWAY --------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_swarm_cluster.id

  tags = {
    Name = "igw_swarm_cluster"
  }
}

# SUBNETS -----------------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.vpc_swarm_cluster.id
  cidr_block        = element(["10.0.0.0/24", "10.0.4.0/24", "10.0.8.0/24"], count.index)
  availability_zone = element(["ap-southeast-1a", "ap-southeast-1a", "ap-southeast-1b"], count.index)
  map_public_ip_on_launch = true 

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

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


resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  route_table_id = aws_route_table.public_rtb.id
  subnet_id = aws_subnet.public[count.index].id
}

# SECURITY GROUPS ---------------------------------------------------------------------------------
resource "aws_security_group" "sg_for_ec2_instance" {
  vpc_id = aws_vpc.vpc_swarm_cluster.id
  name = "sg_for_ec2_instance"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Hạn chế
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 2377
    to_port = 2377
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 7946
    to_port = 7946
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 4789
    to_port = 4789
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# COMPUTE - EC2 -----------------------------------------------------------------------------------
resource "aws_instance" "ec2_instance" {
  count = 3
  ami = "ami-0672fd5b9210aa093"
  instance_type = "t2.micro"
  subnet_id = element(var.public_subnet_ids, count.index)
  key_name = "main-key"
  user_data = file("install-docker.sh")
  vpc_security_group_ids = [ aws_security_group.sg_for_ec2_instance.id ]

  tags = {
    Name = "Node-${count.index + 1}"
  }
}
