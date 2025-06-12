# --- Tạo SSL Certificate (dùng AWS ACM) ---
resource "aws_acm_certificate" "ssl_cert" {
  domain_name       = "hainguyen.io.vn"  # Thay bằng domain của bạn
  validation_method = "DNS"          # Xác thực qua DNS

  lifecycle {
    create_before_destroy = true
  }
}