# COMPUTE - EC2 -----------------------------------------------------------------------------------
resource "aws_instance" "manager-node" {

  ami = "ami-0672fd5b9210aa093"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_for_manager_node.id
  key_name = "main-key"
  user_data = file("install-docker.sh")
  vpc_security_group_ids = [ aws_security_group.sg_for_ec2_instance.id ]

  tags = {
    Name = "manager-node"
  }
}

resource "aws_instance" "jenkins-node" {

  ami = "ami-0672fd5b9210aa093"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_for_jenkins_node.id
  key_name = "main-key"
  user_data = file("install-docker.sh")
  vpc_security_group_ids = [ aws_security_group.sg_for_ec2_instance.id ]

  tags = {
    Name = "jenkins-node"
  }
}

resource "aws_instance" "worker_node_01" {
  ami = "ami-0672fd5b9210aa093"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_for_worker_node_01.id
  key_name = "main-key"
  user_data = file("install-docker.sh")
  vpc_security_group_ids = [ aws_security_group.sg_for_ec2_instance.id ]

  tags = {
    Name = "worker_node_01"
  }
}

resource "aws_instance" "worker_node_02" {
  ami = "ami-0672fd5b9210aa093"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_for_worker_node_02.id
  key_name = "main-key"
  user_data = file("install-docker.sh")
  vpc_security_group_ids = [ aws_security_group.sg_for_ec2_instance.id ]

  tags = {
    Name = "worker_node_02"
  }
}

