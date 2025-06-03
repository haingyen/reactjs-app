# Xuất DNS name của ALB để truy cập ứng dụng
output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}