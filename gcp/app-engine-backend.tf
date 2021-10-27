resource "google_app_engine_application" "app" {
  project     = "localiza-329913"
  location_id = "us-east1"
}

resource "google_project_service" "service" {
  project = "localiza-329913"
  service = "appengineflex.googleapis.com"

  disable_dependent_services = false
}

resource "google_service_account" "service_account" {
  account_id   = "localiza-329913"
  display_name = "Localiza SA - GAE"
}

resource "google_project_iam_member" "gae_api" {
  project = "localiza-329913"
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_app_engine_flexible_app_version" "myapp_v1" {
  version_id = "v1"
  project    = "localiza-329913"
  service    = "default"
  runtime    = "go"

  # entrypoint {
  #   shell = "node ./app.js"
  # }

  deployment {
    container {
      image = "gcr.io/localiza-329913/restic/rest-server:latest"
    }
  }

  liveness_check {
    path = "/"
  }

  readiness_check {
    path = "/"
  }

  env_variables = {
    port = "8080"
  }

  automatic_scaling {
    cool_down_period = "120s"
    cpu_utilization {
      target_utilization = 0.5
    }
  }

  noop_on_destroy = true
}