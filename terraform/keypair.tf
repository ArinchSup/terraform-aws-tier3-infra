resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-${var.environment}-key"
  public_key = file(pathexpand(var.ssh_public_key_path))
  tags = {
    name = "${var.project_name}-${var.environment}-key"
  }
}