provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
    )
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  #host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  #cluster_ca_certificate = base64decode(
    #data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  #)
}