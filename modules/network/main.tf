resource "google_compute_network" "vpc" {
  name                    = "ha-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet-primary"
  ip_cidr_range = "10.10.0.0/16"
  region        = "asia-south1"
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet-secondary"
  ip_cidr_range = "10.20.0.0/16"
  region        = "asia-east1"
  network       = google_compute_network.vpc.id
}
