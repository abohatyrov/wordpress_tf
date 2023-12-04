output "WordPress_Public_IP" {
  description = "The public IP address of the EC2 instance"
  value       = module.wordpress_ec2.public_ip
}
# output "Nagios_Public_IP" {
#   description = "The public IP address of the EC2 instance"
#   value       = module.nagios_ec2.public_ip
# }
output "Prometheus_Public_IP" {
  description = "The public IP address of the EC2 instance"
  value       = module.prometheus_ec2.public_ip
}
output "Docker_Public_IP" {
  description = "The public IP address of the EC2 instance"
  value       = module.docker_ec2.public_ip
}
