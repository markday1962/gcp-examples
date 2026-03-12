variable "project" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "backup_vault_name" {
  type    = string
}

variable "backup_vault_location" {
  type    = string
  default = "europe-west2"
}

variable "backup_plan_name" {
  type    = string
}

variable "hourly_backup_rule" {
  type    = string
}

variable "daily_backup_rule" {
  type    = string
}
