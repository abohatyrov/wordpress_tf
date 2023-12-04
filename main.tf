resource "aws_key_pair" "tf-key-pair" {
  key_name   = local.secret["key_name"]
  public_key = file("${path.module}/.ssh/id_rsa.pub")
}

module "wordpress_ec2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.wordpress_latest.id
  instance_type = local.secret["instance_type"]

  sg_name   = local.secret["wordpress_sg_name"]
  icmp      = local.secret["wordpress_icmp"]
  add_ports = nonsensitive(local.secret["wordpress_ports"])
  key_name  = aws_key_pair.tf-key-pair.key_name

  tags = {
    Name        = local.secret["wordpress_instance_name"]
    Terraform   = true
    Ansible     = true
    Application = local.secret["wordpress_app_name"]
  }
}

module "docker_ec2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.docker_latest.id
  instance_type = local.secret["instance_type"]

  sg_name   = local.secret["docker_sg_name"]
  icmp      = local.secret["docker_icmp"]
  add_ports = nonsensitive(local.secret["docker_ports"])
  key_name  = aws_key_pair.tf-key-pair.key_name

  tags = {
    Name        = local.secret["docker_instance_name"]
    Terraform   = true
    Ansible     = true
    Application = local.secret["docker_app_name"]
  }
}

# module "nagios_ec2" {
#   source = "./modules/ec2"

#   ami           = data.aws_ami.latest_rhel.id
#   instance_type = local.secret["instance_type"]

#   sg_name   = local.secret["nagios_sg_name"]
#   add_ports = nonsensitive(local.secret["nagios_ports"])
#   icmp = local.secret["nagios_icmp"]
#   key_name  = aws_key_pair.tf-key-pair.key_name

#   tags = {
#     Name = local.secret["nagios_instance_name"]
#     Terraform = true
#     Ansible = true
#     Application = local.secret["nagios_app_name"]
#   }
# }

resource "aws_iam_role" "prometheus" {
  name = "prometheus"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "prometheus_policy" {
  name        = "prometheus_policy"
  role        = aws_iam_role.prometheus.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "ec2:DescribeInstances",
      Effect = "Allow",
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "prometheus" {
  name = "prometheus-2d2qd"
  role = aws_iam_role.prometheus.name
}

module "prometheus_ec2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.prometheus_latest.id
  instance_type = local.secret["instance_type"]

  sg_name   = local.secret["prometheus_sg_name"]
  add_ports = nonsensitive(local.secret["prometheus_ports"])
  icmp      = local.secret["prometheus_icmp"]
  key_name  = aws_key_pair.tf-key-pair.key_name

  iam_role  = aws_iam_instance_profile.prometheus.name

  tags = {
    Name        = local.secret["prometheus_instance_name"]
    Terraform   = true
    Ansible     = true
    Application = local.secret["prometheus_app_name"]
  }
}

module "apache_container" {
  source = "./modules/docker"

  image          = local.secret["container_image"]
  tag            = local.secret["container_tag"]
  container_name = local.secret["container_name"]
  docker_host_ip = module.docker_ec2.public_ip

  ports = nonsensitive(local.secret["container_ports"])
}
