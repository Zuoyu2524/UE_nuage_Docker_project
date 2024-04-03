terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.6.0"
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

