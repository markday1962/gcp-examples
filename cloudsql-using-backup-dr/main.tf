resource "google_backup_dr_backup_vault" "default" {
  backup_vault_id                            = var.backup_vault_name
  location                                   = var.backup_vault_location
  backup_minimum_enforced_retention_duration = "86400s" # 30 days in seconds
  project                                    = var.project
  force_update                               = true
  access_restriction                         = "WITHIN_ORGANIZATION"
  backup_retention_inheritance               = "INHERIT_VAULT_RETENTION"
  ignore_inactive_datasources                = true
  allow_missing                              = true
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

resource "google_backup_dr_backup_plan" "this" {
  provider       = google-beta
  backup_plan_id = var.backup_plan_name
  location       = var.backup_vault_location
  resource_type  = "sqladmin.googleapis.com/Instance"
  backup_vault   = google_backup_dr_backup_vault.default.name
  project        = var.project

  backup_rules {
    rule_id               = var.hourly_backup_rule
    backup_retention_days = 1
    standard_schedule {
      recurrence_type     = "HOURLY"
      hourly_frequency    = 6
      time_zone           = "UTC"
      backup_window {
        start_hour_of_day = 0
        end_hour_of_day   = 24
      }
    }
  }
  backup_rules {
    rule_id               = var.daily_backup_rule
    backup_retention_days = 1
    standard_schedule {
      recurrence_type     = "DAILY"
      time_zone           = "UTC"
      backup_window {
        start_hour_of_day = 1
        end_hour_of_day   = 24
      }
    }
  }
  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
