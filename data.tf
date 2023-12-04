data "aws_secretsmanager_secret" "secrets" {
  arn = var.secrets_arn
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

locals {
  secret = jsondecode(data.aws_secretsmanager_secret_version.current.secret_string)
}

data "aws_ami" "wordpress_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = [local.secret["wordpress_ami_name"]]
  }

  owners = [local.secret["ami_owner"]]
}

data "aws_ami" "docker_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = [local.secret["docker_ami_name"]]
  }

  owners = [local.secret["ami_owner"]]
}

data "aws_ami" "prometheus_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = [local.secret["prometheus_ami_name"]]
  }

  owners = [local.secret["ami_owner"]]
}
