resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnets-group"
  subnet_ids = [aws_subnet.private_db_a.id, aws_subnet.private_db_b.id]
  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnets-group"
  }
}

resource "aws_db_instance" "main" {
  identifier               = "${var.project_name}-${var.environment}-db"
  engine                   = "postgres"
  engine_version           = "16.3"
  instance_class           = var.db_instance_class
  allocated_storage        = var.db_allocated_storage
  storage_type             = "gp3"
  storage_encrypted        = true
  db_name                  = var.db_name
  username                 = var.db_username
  password                 = var.db_password
  vpc_security_group_ids   = [aws_security_group.rds_sg.id]
  db_subnet_group_name     = aws_db_subnet_group.main.name
  multi_az                 = var.db_multi_az
  publicly_accessible      = false
  skip_final_snapshot      = true
  delete_automated_backups = true #set this false if use for prod
  backup_retention_period  = 0    #set 0 just to save resource
  tags = {
    Name = "${var.project_name}-${var.environment}-db-instance"
  }
}