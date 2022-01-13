resource "google_sql_database" "database" {
  project  = "projecto-demo-337817"
  name     = "gcp-training-test"
  #instance = "cloudsql-instance"
  instance = google_sql_database_instance.master.name
  charset  = "UTF8"

  depends_on = [google_project_service.project]
}
resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  project       = "projecto-demo-337817"
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = module.vpc.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}
resource "google_sql_database_instance" "master" {
  project             = "projecto-demo-337817"
  provider            = google-beta
  name                = "cloudsql-instance"
  database_version    = "MYSQL_5_6"
  region              = "us-central1"
  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_connection]

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier              = "db-n1-standard-1"
    activation_policy = "ALWAYS"
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.vpc.network_self_link
    }
  }
}