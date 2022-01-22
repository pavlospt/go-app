terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.7.0"
    }
  }

  required_version = ">= 1.0.0"
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
  zone    = var.zone
}

