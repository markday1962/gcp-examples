resource "google_service_account" "bastion_sa" {
  account_id   = var.bastion_name
  display_name = "Bastion Service Account"
}
resource "google_project_iam_member" "bastion_sa_roles" {
  for_each = toset(var.service_account_roles)
  project = var.project_id
  member  = "serviceAccount:${google_service_account.bastion_sa.email}"
  role    = each.value
}
