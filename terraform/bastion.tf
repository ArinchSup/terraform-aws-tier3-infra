resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = aws_key_pair.main.key_name
  tags = {
    Name = "${var.project_name}-${var.environment}-bastion"
  }
  root_block_device {
    encrypted   = true
    volume_type = "gp3"
  }
}