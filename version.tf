terraform {
  required_version = ">= 0.13"
  required_providers {
    helm = "~> 1.0"
    kubernetes = "~> 1.0"
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.0"
    }
    local = "1.4.0"
  }
}

provider "kubernetes" {
  config_context_cluster = "minikube"
}


