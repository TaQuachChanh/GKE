variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "internal-439412"
}

variable "dev_region" {
  description = "GCP Region"
  type        = string
  default     = "asia-southeast1"
}

variable "prod_region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "service_account" {
  description = "Service account email"
  type        = string
  default     = "k8-test@internal-439412.iam.gserviceaccount.com"
}

variable "dev_gke_num_nodes" {
  description = "Number of nodes in each GKE cluster"
  type        = number
  default     = 1
}
variable "prod_gke_num_nodes" {
  description = "Number of nodes in each GKE cluster"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "dev_subnet_cidr" {
  default = "10.0.0.0/18"
}
variable "dev_pods_cidr" {
  default = "10.48.0.0/14"
}
variable "dev_services_cidr" {
  default = "10.52.0.0/20"
}
variable "dev_master_cidr" {
  default = "172.16.0.0/28"
}


variable "prod_subnet_cidr" {
  default = "10.1.0.0/18"
}
variable "prod_pods_cidr" {
  default = "10.56.0.0/14"
}
variable "prod_services_cidr" {
  default = "10.60.0.0/20"
}
variable "prod_master_cidr" {
  default = "172.16.0.32/28"
}