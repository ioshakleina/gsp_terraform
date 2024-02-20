output "instance_public_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].assigned_nat_ip
}

output "instance_image_id" {
  value = google_compute_instance.vm_instance.boot_disk[0].initialize_params[0].image
}

output "instance_type" {
  value = google_compute_instance.vm_instance.machine_type
}

output "instance_network" {
  value = google_compute_instance.vm_instance.network_interface[0].network
}

output "instance_subnet" {
  value = google_compute_instance.vm_instance.network_interface[0].subnetwork
}

output "instance_zone" {
  value = google_compute_instance.vm_instance.zone
}
