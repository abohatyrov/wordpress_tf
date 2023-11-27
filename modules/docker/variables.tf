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

variable "ports" {
  description = "The ports to expose"
  default     = [
    { internal = 80, external = 8080 }
  ]
  type        = list(object({
    internal = number
    external = number
  }))
}

variable "build_context" {
  description = "The build context of the Docker image"
  default     = "../../docker"
  type        = string
}