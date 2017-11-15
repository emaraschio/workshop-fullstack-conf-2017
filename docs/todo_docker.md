## How to create Docker containers

We will use two containers, one for client App and another for the API.
We need to one Dockerfile per application and one docker-compose.yml file to link the containers.

```
docker-compose build
docker-compose up
``` 

Go to: http://localhost:3000

## Push a container to Docker Hub

```
docker login
docker tag name username/container-name
docker push username/container-name
``` 

## Some examples
```
docker tag noteboard-api emaraschio/noteboard-api:latest
docker push emaraschio/noteboard-api:latest

docker tag noteboard-client emaraschio/noteboard-client:latest
docker push emaraschio/noteboard-client:latest
```