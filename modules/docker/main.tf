resource "docker_image" "this" {
  name         = "${var.image}:${var.tag}"
  keep_locally = false
  
  build {
    context = var.build_context
  }
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.this.image_id

  dynamic "ports" {
    for_each = var.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }
}