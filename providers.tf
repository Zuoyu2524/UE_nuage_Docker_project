terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.6.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
  }
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone = var.zone
  credentials = file("tuto-terraform-truan-64446b1c9bb6.json")
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.project_cluster.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.project_cluster.master_auth[0].cluster_ca_certificate,
  )
}

data "google_service_account_access_token" "sa" {
  target_service_account = "880556404666-compute@developer.gserviceaccount.com"
  scopes                 = [ "cloud-platform" ]
}