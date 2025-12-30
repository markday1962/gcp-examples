variable "project_id" {
  description = "Google Cloud Platform project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
}

variable "zone" {
  description = "Google Cloud availability zone"
  type        = string
}

variable "vpc" {
  description = "Google Cloud vpc"
  type        = string
}

variable "bastion_name" {
  description = "Bastion Name"
  type        = string
}

variable "service_account_name" {
  description = "Bastion service account"
  type        = string
}
