data "google_client_config" "provider" {}

data "google_container_cluster" "my_cluster" {
  project  = "projecto-demo-337817"
  name     = "gke-demo-t2"
  location = "us-central1-b"
}