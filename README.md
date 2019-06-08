# docker-ubuntu19-java12
Docker base image of Ubuntu 19.04 to run applications with Java 12

## Getting started

Pulling the image from Docker Hub:

    docker pull docker-ubuntu19-java12
   

Build the image on your on machine:

    docker build -t ubuntu19-java12 .

Running as a container:

    docker run -it ubuntu19-java12 /bin/bash