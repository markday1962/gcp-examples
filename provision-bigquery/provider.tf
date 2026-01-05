terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.14.1" # https://registry.terraform.io/providers/hashicorp/google/latest
    }
  }
}
provider "google" {
  project = var.project_id    # Replace with your project ID
  region  = var.region        # Optional, but good practice
}
