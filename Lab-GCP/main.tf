provider "google" {
  version = "3.5.0"

  credentials = file("/Users/levep/local-Documents/tmp/devops-cloud-275818-463e911b2d65.json")

  project = "devops-cloud-275818"
  region  = "us-central1"
  zone    = "us-central1-c"
}

terraform {
  backend "gcs" {
    bucket  = "terraform-state-275818"
    prefix  = "terraform/state"
  }
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]


  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

