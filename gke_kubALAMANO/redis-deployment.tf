resource "kubernetes_deployment_v1" "redis-deployment" {
  metadata {
    name = "redis-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
    }
    template {
      metadata {
        name = "redis"
        labels = {
          app = "redis"
        }
      }
      spec {
        container {
          name  = "redis"
          image = "redis:alpine"
        }
      }
    }
  }
}