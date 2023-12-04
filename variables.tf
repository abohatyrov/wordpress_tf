variable "region" {
  default     = "us-east-1"
  type        = string
  description = "The AWS region to deploy to"
}

variable "secrets_arn" {
  type    = string
  description = "The ARN of the secrets manager secret"
}
