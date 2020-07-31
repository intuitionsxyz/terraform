provider "google" {
  version = "3.5.0"

  credentials = file("terra.json")

  project = "shining-rush-284917"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  image = "debian-8-jessie-v20170523"
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}
