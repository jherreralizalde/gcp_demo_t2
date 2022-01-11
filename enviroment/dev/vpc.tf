#VPC creation

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id   = "projecto-demo-337817"
  network_name = "demo-network"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "demo-subnet"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    gke-subnet = [
      {
        range_name    = "gke-subnet-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
      {
        range_name    = "gke-subnet-secondary-02"
        ip_cidr_range = "192.168.75.0/24"
      }
    ]


  }
}
