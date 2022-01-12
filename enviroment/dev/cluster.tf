module "gke" {
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id              = "projecto-demo-337817"
  name                    = "gke-demo-t2"
  regional                = true
  region                  = "us-central1"
  zones                   = ["us-central1-b"]
  network                 = module.vpc.network_name
  subnetwork              = "demo-subnet"
  ip_range_pods           = "gke-subnet-secondary-01"
  ip_range_services       = "gke-subnet-secondary-02"
  create_service_account  = false
  service_account         = "t2-demo@projecto-demo-337817.iam.gserviceaccount.com"
  enable_private_endpoint = false
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28"
  

  node_pools = [
    {
      name            = "pool-01"
      #min_count       = 1
      #max_count       = 2
      local_ssd_count            = 0
      disk_size_gb               = 50
      disk_type                  = "pd-standard"
      image_type                 = "COS"
      auto_repair                = true
      service_account = "t2-demo@projecto-demo-337817.iam.gserviceaccount.com"
      machine_type    = "n1-standard-1"
      auto_upgrade    = true
      autoscaling     = true
    }
  ]
}

