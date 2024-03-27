terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

#image redis
resource "docker_image" "redis" {
    name = "docker.io/redis:6.0.5"
}

resource "docker_container" "redis"{
    name = "redis"
    image = docker_image.redis.image_id
    networks_advanced {
        name = docker_network.back-tier.name
    }
}

#image postgres
resource "docker_image" "postgres" {
    name = "docker.io/postgres:15-alpine"
}

resource "docker_container" "db" {
    name = "db"
    image = docker_image.postgres.name
    volumes {
        container_path = "/var/lib/postgresql/data"
        #host_path = docker_volume.db-data
        volume_name    = docker_volume.db-data.name
    } 
    env = [
        "POSTGRES_USER=postgres",
        "POSTGRES_PASSWORD=postgres"
    ]
    networks_advanced {
        name = docker_network.back-tier.name
    }
}

resource "docker_volume" "db-data" {
  name = "db-data"
}

resource "docker_container" "worker"{
    name = "worker"
    image = "europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/worker"
    networks_advanced {
        name = docker_network.back-tier.name
    }
}

resource "docker_container" "vote1"{
    name = "vote1"
    image = "europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/vote"
    ports {
        internal = "5000"
        external = "5000"
    }
    networks_advanced {
        name = docker_network.back-tier.name
    }
    networks_advanced {
        name = docker_network.front-tier.name
    }
}

resource "docker_container" "vote2"{
    name = "vote2"
    image = "europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/vote"
    ports {
        internal = "5000"
        external = "5001"
    }
    networks_advanced {
        name = docker_network.back-tier.name
    }
    networks_advanced {
        name = docker_network.front-tier.name
    }
}

resource "docker_container" "result"{
    name = "result"
    image = "europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/result"
    ports {
        internal = "80"
        external = "5002"
    }
    networks_advanced {
        name = docker_network.back-tier.name
    }
    networks_advanced {
        name = docker_network.front-tier.name
    }
}

resource "docker_container" "nginx"{
    name = "nginx"
    image = "europe-west9-docker.pkg.dev/tuto-terraform-truan/voting-image/nginx"
    ports{
        internal = "80"
        external = "8080"
    }
    networks_advanced {
        name = docker_network.front-tier.name
    }
}

resource "docker_container" "seed"{
  name = "seed"
  image = "docker.io/eloip13009/seed-data"
  networks_advanced {
    name = docker_network.front-tier.name
  }
}

resource "docker_network" "front-tier"{
    name = "front-tier"
}

resource "docker_network" "back-tier"{
    name = "back-tier"
}

output "app_endpoint" {
    value = {
        vote1 = "http://localhost:${docker_container.vote1.ports[0].external}"
        vote2 = "http://localhost:${docker_container.vote2.ports[0].external}"
        result = "http://localhost:${docker_container.result.ports[0].external}"
    }
    description = "The URL endpoint to access the Guestbook application"
}
