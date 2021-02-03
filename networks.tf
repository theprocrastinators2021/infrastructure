resource "google_compute_firewall" "devops-firewall" {
  name    = "devops-firewall"
  network = "devops-network"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]

  depends_on = [google_compute_network.devops-network]
}

resource "google_compute_subnetwork" "development-1" {
  name          = "development-1"
  ip_cidr_range = "172.16.10.0/24"
  region        = "europe-west3"
  network       = google_compute_network.devops-network.id

  depends_on = [
    google_compute_network.devops-network
  ]
}


resource "google_compute_address" "static" {
  name   = "static"
  region = "europe-west3"
  network_tier = "STANDARD"
  }

resource "google_compute_network" "devops-network" {
  name = "devops-network"
  auto_create_subnetworks = false
}


// second network


resource "google_compute_subnetwork" "development-2" {
  name          = "development-2"
  ip_cidr_range = "172.16.20.0/24"
  region        = "europe-west3"
  network       = google_compute_network.devops-network-2.id

  depends_on = [
    google_compute_network.devops-network-2
  ]
}


resource "google_compute_address" "static2" {
  name   = "static2"
  region = "europe-west3"
  network_tier = "STANDARD"
  }

resource "google_compute_network" "devops-network-2" {
  name = "devops-network-2"
  auto_create_subnetworks = false
}


// peer network
resource "google_compute_network_peering" "vpc-peer-jenkins" {
  name         = "vpc-peer-jenkins"
  network      = google_compute_network.devops-network.id
  peer_network = google_compute_network.devops-network-2.id
}

resource "google_compute_network_peering" "vpc-peer-devops-webiste" {
  name         = "vpc-peer-devops-website"
  network      = google_compute_network.devops-network-2.id
  peer_network = google_compute_network.devops-network.id
}