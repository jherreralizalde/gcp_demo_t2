resource "random_string" "password" {
  length  = 16
  special = true
}

resource "google_sql_user" "users" {
  project  = "projecto-demo-337817"
  name     = "user-db"
  host     = "sql-db-demo.com"
  instance = google_sql_database_instance.master.name
  password = sha256(bcrypt(random_string.password.result))
  lifecycle {
    ignore_changes = ["password"]
  }
  depends_on = [google_sql_database_instance.master, random_string.password]
}