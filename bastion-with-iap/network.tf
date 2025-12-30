resource "google_compute_network" "network" {
  name                    = "bastion-with-iap"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet_01" {
  name          = "public-subnet-01"
  ip_cidr_range = "10.10.1.0/24"
  network       = google_compute_network.network.id
  region        = "europe-west2"
}

resource "google_compute_subnetwork" "public_subnet_02" {
  name          = "public-subnet-02"
  ip_cidr_range = "10.10.2.0/24"
  network       = google_compute_network.network.id
  region        = "europe-west2"
}


resource "google_compute_subnetwork" "private_subnet_01" {
  name                     = "private-subnet-01"
  ip_cidr_range            = "10.10.11.0/24"
  network                  = google_compute_network.network.id
  region                   = "europe-west2"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_subnet_02" {
  name                     = "private-subnet-02"
  ip_cidr_range            = "10.10.12.0/24"
  network                  = google_compute_network.network.id
  region                   = "europe-west2"
  private_ip_google_access = true
}
