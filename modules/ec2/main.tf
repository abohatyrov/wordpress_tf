resource "aws_security_group" "wordpress" {
  name = var.sg_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5666
    to_port     = 5666
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

resource "aws_key_pair" "wordpress" {
  key_name   = var.key_name
  public_key = file(var.key_path)
}

resource "aws_instance" "wordpress" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.wordpress.name]

  key_name = aws_key_pair.wordpress.key_name
#  private_ip = "172.31.42.242"

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = var.instance_name
  }
}
