## README

```
terraform plan --var-file keycloak-backup-dr.tfvars
terraform apply --auto-approve --var-file keycloak-backup-dr.tfvars
```

### gcloud commands

```
gcloud backup-dr backup-plans create newtest-plan \
    --location=europe-west2 \
    --resource-type=cloudsql.googleapis.com/Instance \
    --backup-vault=keycloak-backup-vault \
    --backup-rule="rule-id=hourly-rule,retention-days=5,recurrence=HOURLY,hourly-frequency=6,time-zone=UTC,backup-window-start=0,backup-window-end=23"

```

## PROMPT
You are an experienced Google Cloud Engineer use the GCP Backup and DR service
using Terraform google_backup_dr_backup modules create a backup vault and two
backup plans hourly and daily

## Project info
project =
region  = "europe-west2"

## Backup Vault
Create a backup vault with the following attributes

name                         = my_backup_vault
location                     = europe-west1
backup retention             = 30 days
force_update                 = true
access_restriction           = WITHIN_ORGANIZATION
backup_retention_inheritance = INHERIT_VAULT_RETENTION
ignore_inactive_datasources  = true
allow_missing                = true

## Hourly Backup Plan
Now create a backup plan called hourly_backup_plan and associate it with the above
backup vault having the following attributes

name             = hourly_backup_plan
location         = europe-west1
resource type    = cloudsql
backup retention = 1 day

## Hourly Backup Rule
rule id          = hourly-rule
backed up        = hourly
starting at      = 01:00
finishing at     = 23:00

## Daily Backup Plan
Now create a backup plan called daily_backup_plan and associate it with the above
backup vault having the following attributes

name             = daily_backup_plan
location         = europe-west1
resource type    = cloudsql
backup retention = 30 day

## Daily Backup Rule
rule id          = daily-rule
backed up        = daily
starting at      = 00:05

## Output
Output as a terrafrom templates include variable.tf and terraform.tfvar to
manage variables
