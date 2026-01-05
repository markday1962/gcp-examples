gcloud functions deploy get-latest-cloudsql-backup-id \
  --gen2 \
  --runtime python313 \
  --trigger-http \
  --entry-point get_latest_cloudsql_backup_id \
  --allow-unauthenticated \
  --region=europe-west2 \
  --set-env-vars=GCP_PROJECT=YOUR_PROJECT_ID
