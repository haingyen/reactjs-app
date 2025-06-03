# Tạo Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_swarm_cluster.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Đăng ký EC2 vào Target Group
resource "aws_lb_target_group_attachment" "app_tg_manager_node" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.manager-node.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "app_tg_wker1" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.worker_node_01.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "app_tg_wker2" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.worker_node_02.id
  port             = 80
}

# Tạo Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false  # ALB public (truy cập từ Internet)
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet_for_manager_node.id, aws_subnet.subnet_for_jenkins_node.id]

  tags = {
    Name = "AppALB"
  }
}