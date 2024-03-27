resource "kubernetes_service_v1" "db-service" {
  metadata {
    name = "db"
  }
  spec {
    port {
      port = 5432
      target_port = 5432
    }
    selector = {
      app = "guestbook"
    }
  }
}