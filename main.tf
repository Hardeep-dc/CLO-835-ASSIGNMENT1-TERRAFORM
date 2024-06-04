provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "webapp" {
  name = "webapp"
}

resource "aws_ecr_repository" "mysql" {
  name = "mysql"
}

resource "aws_instance" "web" {
  ami           = "ami-00beae93a2d981137"
  instance_type = "t2.micro"

  tags = {
    Name = "web-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              EOF
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
