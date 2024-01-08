terraform {
  backend "s3" {
    bucket = "tfstate-fsa977d"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
    profile = "terraform"
  }
}
