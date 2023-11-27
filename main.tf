module "wordpress_ec2" {
  source = "./modules/ec2"

  instance_name = "wordpress-instance-1"
  ami           = "ami-05a5f6298acdb05b6"
  instance_type = "t2.micro"

  sg_name  = "wordpress-sg"
  icmp     = true
  add_ports = [9100, 9117]
  key_name = "wordpress"
  key_path = "${path.module}/.ssh/id_rsa.pub"
}

module "apache_container" {
  source = "./modules/docker"

  image          = "apache"
  tag            = "latest"
  build_context  = "${path.module}/docker"
  container_name = "apache-container"
  
  ports = [
    { internal = 80, external = 8080 },
    { internal = 9117, external = 9117 }
  ]
}

module "nagios_ec2" {
  source = "./modules/ec2"

  instance_name = "nagios-instance-1"
  ami           = "ami-05a5f6298acdb05b6"
  instance_type = "t2.micro"

  sg_name  = "nagios-sg"
  key_name = "nagios"
  key_path = "${path.module}/.ssh/id_rsa.pub"
}

module "prometheus_ec2" {
  source = "./modules/ec2"

  instance_name = "prom-instance-1"
  ami           = "ami-05a5f6298acdb05b6"
  instance_type = "t2.micro"

  sg_name   = "prom-sg"
  add_ports = [9090]
  key_name  = "prom"
  key_path  = "${path.module}/.ssh/id_rsa.pub"
}