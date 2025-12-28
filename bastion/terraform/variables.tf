variable "project_id" {
  description = "Google Cloud Platform project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
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

variable "bastion_machine_type" {
  description = "Bastion machine type"
  type        = string
}

variable "bastion_image" {
  description = "Bastion Compute Image"
  type        = string
}

variable "bastion_startup_script" {
  description = "Bastion startup script"
  type        = string
}

variable "bastion_tags" {
  description = "Bastion tags"
  type        = list(string)
}

variable "service_account_roles" {
  description = "List of roles to be assigned to the bastion service account"
  type        = list(string)
}
