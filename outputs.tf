output "WordPress_Public_IP" {
  description = "The public IP address of the EC2 instance"
  value = module.wordpress_ec2.public_ip
}

output "Nagios_Public_IP" {
  description = "The public IP address of the EC2 instance"
  value = module.nagios_ec2.public_ip
}
