terraform {
  required_version = ">= 1.4.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

module "web_server" {
  source = "../../modules/compute"

  name         = "stg-web-1"
  machine_type = var.machine_type
  zone         = var.zone
  image        = "debian-cloud/debian-12"
  network      = "default"

  labels = {
    env  = "stg"
    role = "web"
  }
}

