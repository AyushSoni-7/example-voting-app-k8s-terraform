locals {
  app_namespace = "apps"

  db_values = <<ENDYAML
image:
  repository: postgres
  tag: "9.4"
service:
  targetPort: 5432
  port: 5432
  type: ClusterIP
ingress:
  enabled: false
configs:
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: postgres
volume:
  enabled: true
  persistence:
    enables: false
  mountPath: /var/lib/postgresql/data
ENDYAML


  redis_values = <<ENDYAML
image:
  repository: redis
  tag: "alpine"
service:
  targetPort: 6379
  port: 6379
  type: ClusterIP
ingress:
  enabled: false
volume:
  enabled: true
  persistence:
    enables: false
  mountPath: /data
ENDYAML


  voting_app_values = <<ENDYAML
image:
  repository: dockersamples/examplevotingapp_vote
  tag: "before"
service:
  port: 5000
  nodePort: 31000
  type: NodePort
ingress:
  enabled: true
  hosts:
    - host: votingapp.local
      paths:
        - path: /
          pathType: ImplementationSpecific
ENDYAML

  result_app_values = <<ENDYAML
image:
  repository: dockersamples/examplevotingapp_result
  tag: "before"
service:
  port: 5001
  nodePort: 31001
  type: NodePort
ingress:
  enabled: true
  hosts:
    - host: resultapp.local
      paths:
        - path: /
          pathType: ImplementationSpecific
ENDYAML

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
    local.redis_values
  ]
}

resource "helm_release" "postgresdb" {
  name       = "db"
  chart      = "./chart"
  namespace     = local.app_namespace
  values        = [
    local.db_values
  ]
}

resource "helm_release" "votingapp" {
  name          = "voting-app"
  chart         = "./chart"
  namespace     = local.app_namespace
  values        = [
    local.voting_app_values
  ]
}

resource "helm_release" "resultapp" {
  name          = "result-app"
  chart         = "./chart"
  namespace     = local.app_namespace
  values        = [
    local.result_app_values
  ]
}
