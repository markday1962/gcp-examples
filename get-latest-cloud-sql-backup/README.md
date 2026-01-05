## README

### Gemini Prompt
You are a GCP developer, can you write a cloud function in python 3.13 to take an input called cloud-sql-instance-id and retrieve a list of cloud sql backups from the cloud-sql-instance-id and return the latest backup id

Okay, as a GCP developer, I can certainly help you write a Cloud Function in Python 3.13 to retrieve the latest Cloud SQL backup ID for a given instance ID.

This Cloud Function will:

Take cloud-sql-instance-id as an input.
Use the google-cloud-sqladmin client library to list backups for that instance.
Parse the list to find the latest successful backup.
Return the ID of that latest backup.

### Test
```
curl -X POST YOUR_FUNCTION_URL \
  -H "Content-Type: application/json" \
  -d '{"cloud-sql-instance-id": "db-ufonia-dev-dora-app-01"}'
```
