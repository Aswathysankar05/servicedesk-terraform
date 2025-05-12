provider "aws" {
  region = var.region
}

resource "aws_instance" "servicedesk" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "ServiceDeskApp"
  }

  user_data = file("deploy.sh") # bash script to install & deploy app

  vpc_security_group_ids = [aws_security_group.servicedesk_sg.id]
}

resource "aws_security_group" "servicedesk_sg" {
  name        = "servicedesk_sg"
  description = "Allow inbound traffic for app"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_IP/32"] # Restrict SSH to your IP
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Spring Boot
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # React
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
