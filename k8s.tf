resource "google_compute_subnetwork" "private_dev" {
  name                     = "private-dev"
  ip_cidr_range           = var.dev_subnet_cidr
  region                  = var.dev_region
  network                 = google_compute_network.dev.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range-dev"
    ip_cidr_range = var.dev_pods_cidr
  }
  secondary_ip_range {
    range_name    = "k8s-service-range-dev"
    ip_cidr_range = var.dev_services_cidr
  }
}
resource "google_compute_subnetwork" "private_prod" {
  name                     = "private-prod"
  ip_cidr_range           = var.prod_subnet_cidr
  region                  = var.prod_region
  network                 = google_compute_network.prod.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range-prod"
    ip_cidr_range = var.prod_pods_cidr
  }
  secondary_ip_range {
    range_name    = "k8s-service-range-prod"
    ip_cidr_range = var.prod_services_cidr
  }
}

resource "google_container_cluster" "dev" {
  name                     = "dev-cluster"
  location                 = "asia-southeast1-a"
  remove_default_node_pool = true
  initial_node_count       = var.dev_gke_num_nodes
  network                  = google_compute_network.dev.self_link
  subnetwork               = google_compute_subnetwork.private_dev.self_link
  networking_mode          = "VPC_NATIVE"

  node_config{
    disk_size_gb = 30
    disk_type    = "pd-standard"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range-dev"
    services_secondary_range_name = "k8s-service-range-dev"
  }


  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = var.dev_master_cidr
    master_global_access_config {
      enabled = true
    }
  }
   # Thêm cấu hình master authorized networks
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "all"
    }
  }

  # Thêm cấu hình default snat
  default_snat_status {
    disabled = false
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }


  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }


  logging_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }


  release_channel {
    channel = "REGULAR"
  }

  depends_on = [
    google_compute_network.dev,
    google_compute_subnetwork.private_dev
  ]
}

resource "google_container_cluster" "prod" {
  name                     = "prod-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = var.prod_gke_num_nodes
  network                  = google_compute_network.prod.self_link
  subnetwork              = google_compute_subnetwork.private_prod.self_link
  networking_mode         = "VPC_NATIVE"

  node_config{
    disk_size_gb = 30
    disk_type    = "pd-standard"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range-prod"
    services_secondary_range_name = "k8s-service-range-prod"
  }


  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = var.prod_master_cidr
    master_global_access_config {
      enabled = true
    }
  }

    # Thêm cấu hình master authorized networks
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "all"
    }
  }

  # Thêm cấu hình default snat
  default_snat_status {
    disabled = false
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }


  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }


  logging_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }


  release_channel {
    channel = "STABLE"
  }

  depends_on = [
    google_compute_network.prod,
    google_compute_subnetwork.private_prod
  ]
}