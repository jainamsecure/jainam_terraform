terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      # version = "~> 2.13.0"
    }

    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "docker" {}

provider "aws" {
  region = "ap-south-1"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}