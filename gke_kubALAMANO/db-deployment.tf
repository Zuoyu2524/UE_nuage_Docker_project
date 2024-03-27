resource "kubernetes_deployment_v1" "db-deployment" {
  metadata {
    name = "db-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "db"
      }
    }
    template {
      metadata {
        labels = {
          app = "db"
        }
      }
      spec {
        container {
          name  = "db"
          image = "postgres:15-alpine"
          env [
            {
                name = "POSTGRES_USER"
                value = "postgres"
            }
            {
                name = "POSTGRES_PASSWORD"
                value = "postgres"
            }
          ]
        }
      }
    }
  }
}