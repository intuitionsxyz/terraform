provider "google" {
  version = "3.5.0"

  credentials = file("terra.json")

  project = "shining-rush-284917"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "default" {
  name = "my-network"
}

resource "google_compute_subnetwork" "default" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.default.id
}

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "my-internal-address"
  subnetwork   = google_compute_subnetwork.default.id
  address_type = "INTERNAL"
  address      = "10.0.42.42"
  region       = "us-central1"
}
