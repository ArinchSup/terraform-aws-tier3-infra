resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = file("${path.module}/terraform_3tier.pub")
  tags = {
    Name = "${var.project_name}-${var.environment}-key"
  }
}