resource "google_monitoring_alert_policy" "cluster_specific_pod_restart_alert" {
  display_name = "GKE Pod Restart Alert - Cluster: ${var.cluster_name}, Namespace: ${var.target_namespace}"
  combiner     = "OR"

  conditions {
    display_name = "Restart count increase for ${var.target_namespace} in ${var.cluster_name}"
    condition_threshold {
      # Filter for a specific Cluster AND a specific Namespace
      filter     = <<EOT
        resource.type = "k8s_container"
        AND resource.labels.cluster_name = "${var.cluster_name}"
        AND resource.labels.namespace_name = "${var.target_namespace}"
        AND metric.type = "kubernetes.io/container/restart_count"
      EOT

      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_DELTA"
        group_by_fields    = ["resource.labels.pod_name"]
      }
    }
  }

  notification_channels = var.alert_notification_channels
}
