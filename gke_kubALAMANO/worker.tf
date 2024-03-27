resource "kubernetes_deployment_v1" "worker"{
    metadata{
        name= worker
    }
    spec {
        replicas = 1
        selector {
            matchLabels = {
                app = "worker"
            }
        }
        template {
            metadata{
                labels = {
                    app = "worker"
                }
            }
            spec {
                container {
                    name = "worker"
                    containers = image: europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/worker
                }
            }
        }
    }      
}