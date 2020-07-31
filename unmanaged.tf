provider "google" {
  version = "3.5.0"

  credentials = file("terra.json")

  project = "shining-rush-284917"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "instance1" {
  name         = "terraform-instance1"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "instance2" {
  name         = "terraform-instance2"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance_group" "servers" {
  name        = "terraform-servers"
  description = "Terraform unmanaged instance group"

  instances = [
    google_compute_instance.instance1.self_link,
    google_compute_instance.instance2.self_link,
  ]

  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "8443"
  }
zone    = "us-central1-c"
}
