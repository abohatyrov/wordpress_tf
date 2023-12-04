resource "aws_security_group" "this" {
  name = var.sg_name

  dynamic "ingress" {
    for_each = var.add_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.icmp ? [1] : []
    content {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = true
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  depends_on = [var.ec2_depends_on]
}

resource "aws_instance" "this" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.this.name]

  key_name = var.key_name

  iam_instance_profile = var.iam_role

  root_block_device {
    volume_size = 20
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  depends_on = [aws_security_group.this]
}
