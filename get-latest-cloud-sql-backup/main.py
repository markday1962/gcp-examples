import functions_framework
#from google.cloud import sql_admin_v1
from google.cloud.sql_admin_v1.services.sql_admin import SqlAdminClient
from google.cloud.sql_admin_v1.types import ListBackupRunsRequest
import os

@functions_framework.http
def get_latest_cloudsql_backup_id(request):
    """
    HTTP Cloud Function that retrieves the latest successful backup ID for a
    given Cloud SQL instance.

    Args:
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The latest backup ID as a string, or an error message.
    """
    request_json = request.get_json(silent=True)
    request_args = request.args

    cloud_sql_instance_id = None
    if request_json and 'cloud-sql-instance-id' in request_json:
        cloud_sql_instance_id = request_json['cloud-sql-instance-id']
    elif request_args and 'cloud-sql-instance-id' in request_args:
        cloud_sql_instance_id = request_args['cloud-sql-instance-id']

    if not cloud_sql_instance_id:
        return 'Error: Missing cloud-sql-instance-id parameter.', 400

    project_id = os.environ.get('GCP_PROJECT')
    if not project_id:
        # Fallback to default project if not set as environment variable
        # In Cloud Functions, GCP_PROJECT is usually set automatically.
        try:
            from google.auth import default
            _, project_id = default()
        except Exception:
            return 'Error: Could not determine GCP project ID.', 500

    # client = SqlAdminClient()
    #
    # try:
    #     list_request = ListBackupRunsRequest(
    #         project=project_id,
    #         instance=cloud_sql_instance_id
    #     )
    #
    #     backup_runs = client.list_backup_runs(request=list_request)
    #
    #     latest_successful_backup_id = None
    #     latest_backup_creation_time = None
    #
    #     for backup in backup_runs.items:
    #         # Only consider completed backups for "latest"
    #         # You might also filter by 'SUCCESSFUL' status depending on your exact definition of "latest valid backup"
    #         if backup.status == sql_admin_v1.enums.BackupRun.SqlBackupRunStatus.SUCCESSFUL and \
    #            backup.type_ == sql_admin_v1.enums.BackupRun.SqlBackupRunType.AUTOMATED: # Focus on automated backups
    #
    #             # Backup creation_time is a google.protobuf.timestamp_pb2.Timestamp object
    #             # Convert to datetime for comparison
    #             creation_dt = backup.creation_time.ToDatetime()
    #
    #             if latest_backup_creation_time is None or creation_dt > latest_backup_creation_time:
    #                 latest_backup_creation_time = creation_dt
    #                 latest_successful_backup_id = str(backup.id) # Backup ID is typically an integer, convert to string
    #
    #     if latest_successful_backup_id:
    #         return f"Latest successful automated backup ID for instance '{cloud_sql_instance_id}': {latest_successful_backup_id}", 200
    #     else:
    #         return f"No successful automated backups found for instance '{cloud_sql_instance_id}'.", 404
    #
    # except Exception as e:
    #     return f"Error retrieving backups for instance '{cloud_sql_instance_id}': {str(e)}", 500
