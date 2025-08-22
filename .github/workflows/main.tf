provider aws {
    region = "us-west-2"
    }
resource "aws_vpc" "main" {
    cidr_block = "10.0.0/16"
}
resource aws_subnet "main" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1/24"
    availability_zone = "us-west-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "vpce_sg" {
  name        = "vpce-sg"
  description = "Security group for VPC Endpoint"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_vpc.main.default_route_table_id]
}