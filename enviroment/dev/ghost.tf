resource "helm_release" "ghost" {
  namespace        = "jose-herrera-epam-com"
  name             = "ghost"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "ghost"
  create_namespace = true

  set {
    name  = "service.type"
    value = "NodePort"
  }

  set {
    name  = "ghostHost"
    value = "ghost.test"
  }
  set {
    name  = "replicaCount"
    value = 2
  }
}