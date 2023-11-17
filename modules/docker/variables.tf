variable "image" {
  description = "The Docker image to deploy"
  default     = "httpd"
  type        = string
}

variable "tag" {
  description = "The tag of the Docker image to deploy"
  default     = "latest"
  type        = string
}

variable "container_name" {
  description = "The name of the Docker container"
  default     = "apache-container"
  type        = string
}

variable "internal_port" {
  description = "The internal port of the Docker container"
  default     = 80
  type        = number
}

variable "external_port" {
  description = "The external port of the Docker container"
  default     = 8080
  type        = number
}