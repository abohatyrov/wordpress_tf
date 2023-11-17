resource "docker_image" "this" {
  name         = "${var.image}:${var.tag}"
  keep_locally = false
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.this.image_id

  ports {
    internal = var.internal_port
    external = var.external_port
  }
}