resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.nat.id
  depends_on    = [aws_internet_gateway.main]
  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
}

resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-app-private-rt"
  }
}

resource "aws_route_table_association" "private_app_a" {
  route_table_id = aws_route_table.private_app.id
  subnet_id      = aws_subnet.private_app_a.id
}

resource "aws_route_table_association" "private_app_b" {
  route_table_id = aws_route_table.private_app.id
  subnet_id      = aws_subnet.private_app_b.id
}

resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-${var.environment}-db-private-rt"
  }
}

resource "aws_route_table_association" "private_db_a" {
  route_table_id = aws_route_table.private_db.id
  subnet_id      = aws_subnet.private_db_a.id
}

resource "aws_route_table_association" "private_db_b" {
  route_table_id = aws_route_table.private_db.id
  subnet_id      = aws_subnet.private_db_b.id
}