data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "app" {
  name_prefix = "${var.project_name}-${var.environment}-app-"
  image_id = [aws_ami.ubuntu.id]
  instance_type = var.instance_type
  key_name = aws_key_pair.main.arn
  user_data = base64decode(<<-EOF
        #!/bin/bash
        apt-get update
        apt-get install -y nginx
        systemctl start nginx
        systemctl enale nginx
        echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
    EOF
  )
  tag_specifications {
    resource_type = "instanace"
    tags = {
      Name = "${var.project_name}-${var.environment}-app"
    }
  }
}

resource "aws_autoscaling_group" "app" {
    name = "${var.project_name}-${var.environment}-asg"
    vpc_zone_identifier = [aws_vpc.main.id]
  
}