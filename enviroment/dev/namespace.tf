resource "kubernetes_namespace" "demo_namespace" {
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "label-value"
    }

    name = "jose-herrera-epam-com"
  }
}