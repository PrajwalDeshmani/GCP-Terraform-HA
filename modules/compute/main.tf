resource "google_compute_instance_template" "template" {
  name         = "${var.name}-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt update
    apt install -y nginx
    systemctl start nginx
  EOT
}

resource "google_compute_region_instance_group_manager" "mig" {
  name   = "${var.name}-mig"
  region = var.region

  base_instance_name = var.name

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = 2
}
