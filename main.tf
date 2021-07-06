provider "kubernetes" {
  config_context_cluster   = "minikube"
}

locals {
  app_namespaces           =  "apps"
}

resource "kubernetes_namespace" "app_ns" {
  metadata {
    labels = {
      name = locals.app_namespace
    }
    name = locals.app_namespace
  }
}

