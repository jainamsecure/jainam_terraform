# provider "docker" {}

resource "docker_image" "image_nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "container_nginx" {
  image = docker_image.nginx.name
  count = 4
  name  = "container_nginx"
  ports {
    internal = 80
    external = 8080
  }
}