resource "google_container_node_pool" "general_dev" {
  name       = "general-dev"
  cluster    = google_container_cluster.dev.id
  node_count = var.dev_gke_num_nodes

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    
    disk_size_gb = 30
    disk_type    = "pd-standard"

    labels = {
      role = "general"
      env  = "dev"
    }

    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [
    google_container_cluster.dev
  ]
}

resource "google_container_node_pool" "general_prod" {
  name       = "general-prod"
  cluster    = google_container_cluster.prod.id
  node_count = var.prod_gke_num_nodes

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    disk_size_gb = 30
    disk_type    = "pd-standard"

    labels = {
      role = "general"
      env  = "prod"
    }

    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [
    google_container_cluster.prod
  ]
}