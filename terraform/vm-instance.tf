/*provider "google" {
  project = "cogent-anvil-452514-r6"  # Replace with your GCP Project ID
  region  = "us-central1"          # Free tier eligible region
}*/

resource "google_compute_instance" "free_unix_vm" {
  name         = "igreen-data-unix-vm"
  machine_type = "e2-micro"  # Free-tier eligible machine type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Change to "ubuntu-os-cloud/ubuntu-2204-lts" for Ubuntu
      size  = 10   # Disk size in GB (free-tier allows up to 30GB)
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Assigns a public IP
    }
  }

  tags = ["http-server", "https-server"]
}

# Optional: Firewall rule to allow HTTP/HTTPS
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server", "https-server"]
}

