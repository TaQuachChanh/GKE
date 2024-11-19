# NAT cho Dev VPC
resource "google_compute_router_nat" "nat_dev" {
  name   = "nat-dev"
  router = google_compute_router.router_dev.name
  region = var.dev_region

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"

  
  depends_on = [google_container_node_pool.general_dev]
}

# NAT cho Prod VPC
resource "google_compute_router_nat" "nat_prod" {
  name   = "nat-prod"
  router = google_compute_router.router_prod.name
  region = var.prod_region

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"


  depends_on = [google_container_node_pool.general_prod]
}

# IP cho Dev NAT
resource "google_compute_address" "nat_dev" {
  name         = "nat-dev"
  region       = var.dev_region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}

# IP cho Prod NAT
resource "google_compute_address" "nat_prod" {
  name         = "nat-prod"
  region       = var.prod_region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}