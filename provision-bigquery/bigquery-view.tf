resource "google_bigquery_table" "daily_summary_view" {
  dataset_id = google_bigquery_dataset.analytics_data.dataset_id
  table_id   = "daily_summary_view"
  view {
    query = <<EOF
SELECT
  DATE(timestamp) as event_date,
  COUNT(DISTINCT user_id) as daily_active_users
FROM
  ${google_bigquery_dataset.analytics_data.dataset_id}.${google_bigquery_table.events_table.table_id}
GROUP BY 1
EOF
    use_legacy_sql = false
  }
}
