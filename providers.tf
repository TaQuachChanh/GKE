provider "google" {
  project     = var.project_id
  region      = "asia-southeast1"
  credentials = file("./creds/k8-test.json")
}

terraform {
  backend "gcs" {
    bucket  = "k8_bucket"
    prefix  = "terraform/state"
    credentials = "./creds/k8-test.json"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}