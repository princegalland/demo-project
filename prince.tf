provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

# Create private subnet within the VPC
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"  # Example CIDR block for private subnet
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "public_instance_sg" {
  name        = "public_instance_sg"
  description = "Allow inbound traffic to the public instance"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Add additional ingress rules as needed
}

resource "aws_instance" "public_instance" {
  ami           = "ami-051f8a213df8bc089"  # Replace with the AMI ID of the instance you want to launch
  instance_type = "t2.micro"     # Example instance type, replace with your desired instance type
  subnet_id     = aws_subnet.public_subnet.id
  #security_groups = [aws_security_group.public_instance_sg.name]

  tags = {
    Name = "public-instance"
  }
}
