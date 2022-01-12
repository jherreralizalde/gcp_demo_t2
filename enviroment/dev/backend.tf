terraform {
  backend "gcs" {
    bucket = "gcp_demo_jh_t2"
    prefix = "terraform/environment/dev"
  }
}