locals {
  app_namespace = "apps"
}

resource "kubernetes_namespace" "app_ns" {
  metadata {
    labels = {
      name = local.app_namespace
    }
    name = local.app_namespace
  }
}

resource "helm_release" "redisapp" {
  name       = "redis"
  chart      = "./chart"
  namespace     = local.app_namespace
  values        = [
    "${file("patches/redis.yaml")}"
  ]
}

resource "helm_release" "postgresdb" {
  name       = "db"
  chart      = "./chart"
  namespace     = local.app_namespace
  values        = [
    "${file("patches/db.yaml")}"
  ]
}

resource "helm_release" "votingapp" {
  name          = "voting-app"
  chart         = "./chart"
  namespace     = local.app_namespace
  values        = [
    "${file("patches/voting_app.yaml")}"
  ]
}

resource "helm_release" "resultapp" {
  name          = "result-app"
  chart         = "./chart"
  namespace     = local.app_namespace
  values        = [
    "${file("patches/result_app.yaml")}"
  ]
}

resource "kubernetes_deployment" "worker" {
  metadata {
    name = "worker"
    labels = {
      app = "worker"
    }
    namespace = local.app_namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "worker"
      }
    }
    template {
      metadata {
        labels = {
          app = "worker"
        }
      }
      spec {
        container {
          image = "dockersamples/examplevotingapp_worker"
          name  = "worker-container"
        }
      }
    }
  }
}

