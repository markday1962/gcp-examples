resource "google_bigquery_table" "events_table" {
  dataset_id = google_bigquery_dataset.analytics_data.dataset_id # Reference the dataset above
  table_id   = "events"

  # Table schema defined as a JSON string
  schema = <<EOF
[
  {
    "name": "timestamp",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "Event timestamp"
  },
  {
    "name": "user_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Unique user identifier"
  },
  {
    "name": "event_name",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Name of the event (e.g., page_view)"
  }
]
EOF
 # Optional: Configure Partitioning (e.g., by day on the 'timestamp' field)
  time_partitioning {
    type    = "DAY"
    field   = "timestamp"
  }
# Optional: Configure Clustering
  clustering = ["user_id"]
}
