resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}

# VPC cho Dev Environment (Singapore)
resource "google_compute_network" "dev" {
  name                    = "dev-vpc"
  auto_create_subnetworks = false
}


# Router cho Dev VPC
resource "google_compute_router" "router_dev" {
  name    = "dev-router"
  region  = var.dev_region
  network = google_compute_network.dev.id
}

# VPC cho Prod Environment (Jakarta)
resource "google_compute_network" "prod" {
  name                    = "prod-vpc"
  auto_create_subnetworks = false
}



# Router cho Prod VPC
resource "google_compute_router" "router_prod" {
  name    = "prod-router"
  region  = var.prod_region
  network = google_compute_network.prod.id
}