module "wordpress_ec2" {
  source = "./modules/ec2"

  instance_name = "wordpress-instance-1"
  ami           = "ami-05a5f6298acdb05b6"
  instance_type = "t2.micro"

  sg_name  = "wordpress-sg"
  key_name = "wordpress"
  key_path = "${path.module}/.ssh/id_rsa.pub"
}

module "apache_container" {
  source = "./modules/docker"

  image          = "httpd"
  tag            = "latest"
  container_name = "apache-container"
  internal_port  = 80
  external_port  = 8080
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
