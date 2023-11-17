resource "aws_security_group" "nagios" {
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "nagios" {
  key_name   = var.key_name
  public_key = file(var.key_path)
}

resource "aws_iam_role" "ssm_role_nagios" {
  name = "ssm_role_nagios"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_role_attachment_nagios" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role_nagios.name
}

resource "aws_instance" "nagios" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.nagios.name]

  key_name = aws_key_pair.nagios.key_name

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile_nagios.name

#  private_ip = "172.31.42.162"

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_iam_instance_profile" "ssm_instance_profile_nagios" {
  name = "ssm_instance_profile_nagios"
  role = aws_iam_role.ssm_role_nagios.name
}
