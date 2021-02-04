provider "google" { 
    project = "ivory-amphora-301512"
    region = "europe-west3" 
    zone = "europe-west3-a" 
} 


resource "google_compute_instance" "devops-jenkins" {
    name = "devops-jenkins"
    machine_type = "e2-small"
    tags = ["devops-jenkins"]


    boot_disk {
    initialize_params {
        image = "https://www.googleapis.com/compute/v1/projects/ivory-amphora-301512/global/images/devops-image"
        }
    }


    network_interface {
        network = "devops-network"
        subnetwork = "development-1"
        network_ip = "172.16.10.5"

        access_config {
                nat_ip = google_compute_address.static.address
                network_tier = "STANDARD"
            }
        }
    depends_on = [
        google_compute_network.devops-network,
        google_compute_subnetwork.development-1
    ]
}

resource "google_compute_instance" "devops-website" {
    name = "devops-website"
    machine_type = "e2-small"
    tags = ["devops-website"]


    boot_disk {
    initialize_params {
        image = "https://www.googleapis.com/compute/v1/projects/ivory-amphora-301512/global/images/devops-image"
        }
    }

    depends_on = [
        google_compute_network.devops-network-2,
        google_compute_subnetwork.development-2
    ]


    network_interface {
        network = "devops-network-2"
        subnetwork = "development-2"
        network_ip = "172.16.20.5"
        access_config {
            nat_ip = google_compute_address.static2.address
            network_tier = "STANDARD"
        }
    }
}
