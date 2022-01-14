module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = "cron-demo"
  namespace  = "jose-herrera-epam-com"
  project_id = "projecto-demo-337817"
  roles      = ["roles/storage.admin", "roles/cloudsql.client"]

  depends_on = [module.gke]
}
resource "kubernetes_cron_job" "demo" {
  metadata {
    namespace        = "jose-herrera-epam-com"  
    name = "cronjob-debil"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule                      = "*/5 * * * *"
    starting_deadline_seconds     = 60
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            automount_service_account_token = true
            service_account_name = "cron-demo"
            #restart_policy = "Never"  
            container {
              name    = "docker-script"
              image   = "us.gcr.io/projecto-demo-337817/docker-demo:1.0.0"
              command = ["/bin/ash", "-c", "date; export MYSQL_PWD=${random_string.password.result}; sleep 5 && mysqldump -h 127.0.0.1 -u user-db gcp-training-test >> /tmp/db.txt && gsutil cp /tmp/db.txt gs://gcp_demo_jh_t2/; echo Hello from the Kubernetes cluster"]
            }
             container {
              name    = "proxy"
              image   = "us.gcr.io/cloudsql-docker/gce-proxy:1.28.0-alpine"
              command = ["/cloud_sql_proxy", "-instances=projecto-demo-337817:us-central1:cloudsql-instance=tcp:3306"]
            }
        }
      }
    }
  }
}
depends_on = [module.my-app-workload-identity, google_sql_database.database]
}