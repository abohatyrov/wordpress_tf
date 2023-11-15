output "IP_Address" {
  value = "${aws_instance.wordpress.public_ip}"
}