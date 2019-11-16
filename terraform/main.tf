provider "google" {
  version = "~> 2.11.0"
  project = var.project
  region  = var.region
  credentials = "${file("~/.config/GCP/opsprolab-asterisk-docker-ac2583b8f7b6.json")}"
}
resource "google_compute_address" "static-ip-address" {
  name = "static-ip-address"
}

/* resource "google_compute_network" "vpc_network" {
  name                    = "telegram-network"
  auto_create_subnetworks = "true"
} */
#описываем правила фаервола
resource "google_compute_firewall" "firewall_app_ssh" {
  name    = "allow"
  network = "default"

  allow {
    protocol = "udp"
    ports    = ["40000-45000"]
  }

  allow {
    protocol = "tcp"
    ports    = ["1080", "22", "3128", "443", "563"]
  }

    source_ranges = ["0.0.0.0/0"]
  target_tags   = ["telegram-proxy"]
}

resource "google_compute_instance" "proxy" {
  name         = "telegram-proxy"
  machine_type = var.machine_type
  zone         = var.zone
  count        = var.proxy_count
  tags         = ["telegram-proxy"]

/* metadata = {
    sshKeys = "${var.instance_ssh_username}:${var.instance_ssh_pub_key}"
  }
metadata_startup_script = "echo 'Proxy install script will go here' > test.txt" */

  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = "10"
    }
  }

  network_interface {
     network = "default"
     access_config {
      nat_ip = "${google_compute_address.static-ip-address.address}"
    }
  }
  metadata = {
    ssh-keys = "root:${file(var.public_key_path)}"
  }
#запуск ansible provision
provisioner "local-exec" {
    command = <<EOT
    sleep 30;
    ansible-playbook -i '${google_compute_address.static-ip-address.address},' -u root ../ansible/deploy.yml
    EOT
  }
}

