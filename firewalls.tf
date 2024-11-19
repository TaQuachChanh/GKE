# Firewall rules cho Dev VPC
resource "google_compute_firewall" "allow-ssh-dev" {
  name    = "allow-ssh-dev"
  network = google_compute_network.dev.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  depends_on = [google_container_cluster.dev]
}

resource "google_compute_firewall" "allow-egress-dev" {
  name    = "allow-egress-dev"
  network = google_compute_network.dev.name

  allow {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
  source_ranges     = [var.dev_subnet_cidr, var.dev_pods_cidr]
}

resource "google_compute_firewall" "allow_master_dev" {
  name    = "allow-master-dev"
  network = google_compute_network.dev.name

  allow {
    protocol = "tcp"
    ports    = ["443", "10250"]
  }

  source_ranges = [var.dev_master_cidr]
}

# Firewall rules cho Prod VPC
resource "google_compute_firewall" "allow-ssh-prod" {
  name    = "allow-ssh-prod"
  network = google_compute_network.prod.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  depends_on = [google_container_cluster.prod]
}

resource "google_compute_firewall" "allow-egress-prod" {
  name    = "allow-egress-prod"
  network = google_compute_network.prod.name

  allow {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
  source_ranges     = [var.prod_subnet_cidr, var.prod_pods_cidr]
}

resource "google_compute_firewall" "allow_master_prod" {
  name    = "allow-master-prod"
  network = google_compute_network.prod.name

  allow {
    protocol = "tcp"
    ports    = ["443", "10250"]
  }

  source_ranges = [var.prod_master_cidr]
}