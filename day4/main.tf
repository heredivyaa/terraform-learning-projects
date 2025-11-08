# Define the AWS provider configuration
provider "aws" {
  region = "ap-south-1" # Replace with your desired AWS region
}

variable "cidr" {
  default = "10.0.0.0/16"
}

# Create a key pair using your public key
resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-abhi"
  public_key = file("/Users/divyasharma/.ssh/id_rsa.pub") # Public key is correct here
}

# Create VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

# Create Subnet
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a" # ✅ Add AZ suffix (a/b/c)
  map_public_ip_on_launch = true
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

# Route Table
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Route Table Association
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

# Security Group
resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Flask Port"
    from_port   = 5050 # ✅ Flask default port
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

# EC2 Instance
resource "aws_instance" "server" {
  ami                    = "ami-087d1c9a513324697"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id

  # ✅ FIX: Use private key, not public key
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/divyasharma/.ssh/id_rsa") # Not .pub
    host        = self.public_ip
  }

  # Copy Flask app to instance
  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  # Install Python + Flask and run app
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y python3-pip",
      "pip3 install flask",
      "nohup python3 /home/ubuntu/app.py > app.log 2>&1 &" # ✅ run in background safely
    ]
  }

  tags = {
    Name = "Terraform-Flask-Server"
  }
}
