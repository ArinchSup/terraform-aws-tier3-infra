output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "public dns name of the application LB"
}

output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "public ip address of the bastion host"
}

output "rds_endpoint" {
  value       = aws_db_instance.main.endpoint
  sensitive   = true
  description = "connection endpoint for the RDS DB"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "unique identifier of the VPC"
}