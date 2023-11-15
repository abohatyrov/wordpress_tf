variable "region" {
  default = "us-east-1"
  type = string
  description = "The AWS region to deploy to"
}

variable "key_name" {
  default = "wordpress_tf"
  type = string
  description = "The name of the SSH key to use"
}

variable "ami" {
  default = "ami-05a5f6298acdb05b6"
  type = string
  description = "The AMI to use for the EC2 instance"
}
variable "instance_type" {
  default = "t2.micro"
  type = string
  description = "The type of EC2 instance to use"  
}