resource "docker_image" "this" {
  name         = "${var.image}:${var.tag}"
  keep_locally = false

  dynamic "build" {
    for_each = var.build_context != "" ? [1] : []
    content {
      context    = var.build_context
      dockerfile = "${var.build_context}/Dockerfile"
    }
  }

  depends_on = [var.docker_depends_on]
}

resource "docker_container" "this" {
  name  = var.container_name
  image = docker_image.this.image_id

  restart = "always"

  dynamic "ports" {
    for_each = var.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }

  dynamic "volumes" {
    for_each = var.volumes
    content {
      host_path      = volumes.value.host_path
      container_path = volumes.value.container_path
      read_only      = volumes.value.read_only
    }
  }

  depends_on = [docker_image.this]
}
