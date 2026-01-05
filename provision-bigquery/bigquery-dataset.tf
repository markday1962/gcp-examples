resource "google_bigquery_dataset" "analytics_data" {
  dataset_id                  = "analytics_dataset"
  friendly_name               = "Analytics Data"
  description                 = "Dataset for storing web analytics data."
  location                    = "UK" # Must be the same or compatible with your project's location
  default_table_expiration_ms = 36000000 # Optional: 10 hours expiration for tables
access {
    role          = "OWNER"
    user_by_email = "markday922@gmail.com" # Replace with an actual email
  }

  # Example for IAM - grants BigQuery Data Viewer to a group
  access {
    role  = "READER"
    group_by_email = "markday922@gmail.com"
  }

# Prevent accidental deletion of the dataset
  lifecycle {
    prevent_destroy = true
  }
}
