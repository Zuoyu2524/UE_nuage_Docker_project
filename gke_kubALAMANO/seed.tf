resource "" "seed" {
  metadata {
    name = "seed"
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