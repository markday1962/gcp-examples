provider "google" {
  project = "earnest-triumph-470914-i5"
  region  = "europe-west2"
  zone    = "europe-west2-a"
}

resource "google_cloud_run_service" "sample_service" {
  name = "sample-service"
  location = "europe-west2"
  template {
    spec {
      containers {
        image = "https://gcr.io/google-samples/hello-app:1.0"
      }
    }
  }
}

resource "google_cloud_run_service_iam_policy" "public_access" {
  service = google_cloud_run_service.sample_service.name
  location = google_cloud_run_service.sample_service.location
  policy_data = data.google_iam_policy.public_iam_policy.policy_data
}

data "google_iam_policy" "public_iam_policy" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}
