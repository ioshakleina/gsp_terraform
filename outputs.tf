output "instance_public_ip" {
  description = "Public IP address of the instance"
  value       = google_compute_instance.instance.network_interface.0.access_config.0.nat_ip
}

output "instance_image_id" {
  description = "ID of the instance image"
  value       = google_compute_instance.instance.boot_disk.0.initialize_params.0.image
}

output "instance_type" {
  description = "Type of the instance"
  value       = var.instance_type
}

output "instance_network" {
  description = "Network of the instance"
  value       = google_compute_network.network.self_link
}

output "instance_subnet" {
  description = "Subnetwork of the instance"
  value       = google_compute_subnetwork.subnet.self_link
}

output "instance_zone" {
  description = "Zone of the instance"
  value       = var.zone
}
