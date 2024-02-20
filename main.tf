# Configure the GCP provider
provider "google" {
  credentials = file("<path_to_your_service_account_key_json_file>")
  project     = var.project
  region      = var.region
}

# Create VPC
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

# Create Subnet
resource "google_compute_subnetwork" "vpc_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
}

# Create Compute Engine Instance
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image_family = var.image_family
      image_project = var.image_project
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.vpc_subnet.name
  }

  metadata_startup_script = <<-EOF
                            #!/bin/bash
                            apt-get update
                            apt-get install -y apache2
                            systemctl start apache2
                            EOF

  tags = var.network_tags
}

# Create Firewall Rule
resource "google_compute_firewall" "firewall" {
  name    = "allow-ports"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = ["0.0.0.0/0"]
}
