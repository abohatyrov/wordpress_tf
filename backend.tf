terraform {
  backend "s3" {
    bucket = "tfstate-83138"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
