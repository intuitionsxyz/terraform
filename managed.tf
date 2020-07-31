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
resource "google_compute_instance_template" "template" {
  name_prefix = "my-template-"

  machine_type = "f1-micro"
  region       = "us-central1"
network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    disk_type    = "pd-standard"
    source_image = "ubuntu-os-cloud/ubuntu-1804-lts"
    disk_size_gb = "20"
  }
lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "mig" {
  name               = "my-mig"
  base_instance_name = "mig-instance"
  region             = "us-central1"
  target_size        = 2
  wait_for_instances = true

version {
    instance_template = google_compute_instance_template.template.self_link
  }

  timeouts {
    create = "15m"
    update = "15m"
  }
update_policy {
  type                         = "PROACTIVE"
  instance_redistribution_type = "PROACTIVE"
  minimal_action               = "REPLACE"
}
lifecycle {
    create_before_destroy = true
  }
}
