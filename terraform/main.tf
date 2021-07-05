provider "kubernetes" {
  config_context_cluster   = "minikube"
}

locals {
  application_namespaces   = ["frontend", "backend", "database"]
}

resource "kubernetes_namespace" "1-minikube-namespace" {
  for_each = toset(local.application_namespaces)
  metadata {
    labels = {
      name = each.value
    }
    name = each.value
  }
}

