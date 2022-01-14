resource "random_string" "password" {
  length  = 16
  special = true
}

resource "google_sql_user" "users" {
  project  = "projecto-demo-337817"
  name     = "user-db"
  host = "%"
  instance = google_sql_database_instance.master.name
  password = random_string.password.result

  depends_on = [google_sql_database_instance.master, random_string.password]
}