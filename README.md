# Projet Docker-Kubernetes-Terraform UE Nuage LOGIN

Thomas RUAN, Zuoyu ZHANG

# Table of Content

  * [Docker project](#docker-project)
  * [Kubernetes project](#kubernetes-project)
  * [Terraform project](#terraform-project)

# Docker project

The goal of the project is to deploy the following application by using Docker and Docker compose. 

![image](login-nuage-voting.drawio.svg)

In this project, we finished: 
- one Dockerfile per service that exposes the internal port of the container
- one docker-compose.yml file to deploy the stack
- adequate `depends_on`
- two networks: `front-net` and `back-net`

To start this Docker container, you need firstly clone all the project files by using code 

    git clone https://github.com/Zuoyu2524/UE_nuage_Docker_project.git
    
Then go to the project folder

    cd UE_nuage_Docker_project

Check your Docker running state and build the Docker containers firstly by the code

    docker compose build
    
After this, you can start the Docker applications by the code

    docker compose up -d
    
Now you can visit the websites in these following links:
- vote1: http://localhost:5000
- vote2: http://localhost:5001
- result: http://localhost:5002

### However, the seed service does not work due to our OS Windows : the command "CMD [ "/bin/sh", "./generate-votes.sh" ]" does not work

# Kubernetes project

The goal of this project is to deploy the previous application to a Kubernetes cluster

The details of Deploying a working application (with temporary database store)

* `vote`, `result`, `redis` and `db`, each with a `Deployment` and a `Service`.
* `worker` only needs a `Deployment`.
* `seed` will be run as a `Job` that is *not restarted*.

To run the Kubernetes project by using the codes in this repository， go the kubernetes_manifest folder 

    cd kubernetes_manifest
    
Firstly, you need create a deployment by the following codes:

    kubectl create -f db-deployment.yaml
    
    kubectl create -f db-service.yaml
    
    kubectl create -f redis-deployment.yaml
    
    kubectl create -f redis-service.yaml
    
    kubectl create -f result-deployment.yaml
    
    kubectl create -f result-service.yaml
    
    kubectl create -f vote-deployment.yaml
    
    kubectl create -f vote-service.yaml
    
    kubectl create -f seed.yaml
    
    kubectl create -f worker.yaml

After creating all above, use following code to check the services

    kubectl get services

Now you can visit the websites in these following links:
- vote1: http://localhost:5000
- vote2: http://localhost:5001
- result: http://localhost:5002

## Appendix: Useful commands

Print the list of resources we can declare in a manifest, i.e. available values of `apiVersion` and `kind`

    kubectl api-resources

Print the documentation of a resource, i.e. the accepted fields in the manifest

    kubectl explain deployment.spec.template.spec.containers.livenessProbe


Print the logs of a container. When selecting a pod, `kubectl` will choose one. The `-f` options means "follow", i.e. print the logs continuously, akin to the Linux `tail -f` command.

    kubectl logs -f pods/vote<TAB>


Apply *all* manifests of a repository

    kubectl apply -f k8s-manifests/


Show resources continuously (refreshed every one second) with `watch`. Beware, `all` do not mean *all* resources, only "user" resources. E.g. `PersistentVolume`s and `StorageClass`es are not showed.

    watch -n1 kubectl get all

# Terraform project

## Objectives

The objective is to use Terraform to deploy the voting app.

## Part 1 mandatory - Docker

In this part, firstly you need go to the tf-docker folder

    cd tf-docker

Then you can run these three codes to finish the development.

    terraform init

    terraform plan

    terraform apply

Now you can visit the websites in these following links:
- vote1: http://localhost:5000
- vote2: http://localhost:5001
- result: http://localhost:5002

### However, the seed service does not work while using the image from eloip130009/seed-data


## Part 2 mandatory - GKE and Kubernetes
In this part, firstly you need go to the tf-gke folder

    cd tf-gke

Then you can run these three codes to finish the development.

    terraform init

    terraform plan

    terraform apply
    
After that, go to the folder tf-kubernetes `cd tf-kubernetes` to run the same three codes

Now you can visit the websites in these following links:
- vote1: http://localhost:5000
- vote2: http://localhost:5001
- result: http://localhost:5002

### However, the seed service does not work while using the image from eloip130009/seed-data