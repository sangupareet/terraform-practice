# Create VPC
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test"
  }
}

# Create IG and attach to VPC
resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id
}

# Create subnet
resource "aws_subnet" "test" {
  vpc_id = aws_vpc.test.id
}

# Create RT and provide path from IG to RT
resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id
}

# Associate subnet to RT
resource "aws_route_table_association" "test" {
  route_table_id = aws_route_table.test.id
  subnet_id = aws_subnet.test.id
}

# Create instance
resource "aws_instance" "test" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
}

# Create S3 bucket
resource "aws_s3_bucket" "test" {
  bucket = "mys3"
}
resource "aws_s3_bucket_versioning" "test" {
  bucket = aws_s3_bucket.test.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Create security group
resource "aws_security_group" "test" {
  name = "test-sg"
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "test-sg"
  }
  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
