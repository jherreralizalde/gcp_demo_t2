resource "kubernetes_ingress_v1" "example_ingress" {
  metadata {
    name      = "ingress-ghost"
    namespace = "jose-herrera-epam-com"
  }

  spec {
    rule {
      host = "ghost.test"
      http {
        path {
          backend {
            service {
              name = "ghost"
              port {
                number = 80
              }
            }
          }

          path = "/*"
        }
      }
    }
  }
  depends_on = [helm_release.ghost]
}

