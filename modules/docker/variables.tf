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
  default = [
    { internal = 80, external = 8080 }
  ]
  type = list(object({
    internal = number
    external = number
  }))
}

variable "build_context" {
  description = "The build context of the Docker image"
  default     = ""
  type        = string
}

variable "volumes" {
  description = "The volumes to mount"
  default     = []
  type = list(object({
    host_path      = string
    container_path = string
    read_only      = bool
  }))
}

variable "docker_host_ip" {
  description = "The IP address of the Docker host"
  default     = "127.0.0.1"
  type        = string
}

variable "docker_depends_on" {
  default     = []
  type        = list(string)
  description = "Additional dependencies for the EC2 instance"
}

variable "loki_url" {
  description = "The URL of the Loki server"
  default     = ""
  type        = string
}

variable "env" {
  description = "The environment variables to set"
  default     = []
  type = list(string)
}