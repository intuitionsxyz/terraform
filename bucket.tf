provider "google" {
  version = "3.5.0"

  credentials = file("terra.json")

  project = "shining-rush-284917"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "auto-expire" {
  name          = "autoexp3107"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = "1"
    }
    action {
      type = "Delete"
    }
  }
}
