resource "google_project_service" "project" {
  project = "projecto-demo-337817"
  service = "servicenetworking.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = false
  disable_on_destroy         = false
}
resource "google_project_service" "demo" {
  project = "projecto-demo-337817"
  service = "cloudfunctions.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = false
  disable_on_destroy         = false
}
resource "google_project_service" "api-3" {
  project = "projecto-demo-337817"
  service = "cloudbuild.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = false
  disable_on_destroy         = false
}
