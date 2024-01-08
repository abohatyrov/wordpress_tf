terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13"
    }
  }
}

provider "aws" {
  shared_config_files      = [".aws/config"]
  shared_credentials_files = [".aws/credentials"]
}

provider "docker" {
  host = "tcp://${module.docker_ec2.public_ip}:2376"
}

