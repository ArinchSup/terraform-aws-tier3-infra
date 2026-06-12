data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "app" {
  name_prefix            = "${var.project_name}-${var.environment}-app-"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.main.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  user_data = base64encode(<<-EOF
        #!/bin/bash
        apt-get update
        apt-get install -y nginx
        systemctl start nginx
        systemctl enable nginx
        echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
    EOF
  )
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${var.environment}-app"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                      = "${var.project_name}-${var.environment}-asg"
  vpc_zone_identifier       = [aws_subnet.private_app_a.id, aws_subnet.private_app_b.id]
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = 300
  target_group_arns         = [aws_lb_target_group.app.arn]
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-asg"
    propagate_at_launch = true
  }
}