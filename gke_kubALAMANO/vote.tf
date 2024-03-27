resource "kubernetes_deployment_v1" "vote" {
  metadata {
    name = "vote"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "vote"
      }
    }
    template {
      metadata {
        labels = {
          app = "vote"
        }
      }
      spec {
        container {
          name  = "vote"
          image = europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/vote
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "vote" {
  metadata {
    name = "vote"
  }
  spec {
    port {
      port = 5000
      target_port = 5000
    }
    type = "LoadBalancer"
    selector = {
      app = "vote"
    }
  }
}