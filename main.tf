provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_network" "network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.network.self_link
  ip_cidr_range = var.subnet_cidr
}

resource "google_compute_instance" "instance" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
    }
  }

  network_interface {
    network = google_compute_network.network.id
    subnetwork = google_compute_subnetwork.subnet.id
  }

  metadata = {
    environment = var.environment
  }

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }
}

