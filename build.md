# BUILD

## First steps

- Check files use `LF` line endings (linux style).  

## Build docker image

### ubuntu

    docker build -t openjdk17-ubuntu -f openjdk17-ubuntu.Dockerfile .

### alpine

    docker build -t openjdk17-alpine -f openjdk17-alpine.Dockerfile .

## Build and push for all architectures

https://docs.docker.com/buildx/working-with-buildx  
https://www.docker.com/blog/multi-arch-images  

    docker buildx ls
    docker buildx rm mybuilder
    docker buildx create --name mybuilder
    docker buildx use mybuilder
    docker buildx inspect --bootstrap

### OpenJDK 8

#### dev-alpine

    docker buildx build --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/jdownloader:dev-openjdk8-alpine -f openjdk8-alpine.Dockerfile --push .

#### dev-ubuntu

    docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/jdownloader:dev-openjdk8-ubuntu -f openjdk8-ubuntu.Dockerfile --push .

#### alpine

    docker buildx build --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/jdownloader:openjdk8-alpine -f openjdk8-alpine.Dockerfile --push .

#### ubuntu

    docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t antlafarge/jdownloader:openjdk8-ubuntu -t antlafarge/jdownloader:openjdk8 -f openjdk8-ubuntu.Dockerfile --push .

### OpenJDK 17

#### dev-alpine

    docker buildx build --platform linux/amd64,linux/arm64/v8,linux/s390x -t antlafarge/jdownloader:dev-openjdk17-alpine -f openjdk17-alpine.Dockerfile --push .

#### dev-ubuntu

    docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/s390x -t antlafarge/jdownloader:dev-openjdk17-ubuntu -f openjdk17-ubuntu.Dockerfile --push .

#### alpine

    docker buildx build --platform linux/amd64,linux/arm64/v8,linux/s390x -t antlafarge/jdownloader:openjdk17-alpine -t antlafarge/jdownloader:alpine -f openjdk17-alpine.Dockerfile --push .

#### ubuntu (and latest because more stable)

    docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/s390x -t antlafarge/jdownloader:openjdk17-ubuntu -t antlafarge/jdownloader:openjdk17 -t antlafarge/jdownloader:ubuntu -t antlafarge/jdownloader:latest -f openjdk17-ubuntu.Dockerfile --push .

## Debug container

    docker exec -it --user root jdownloader /bin/bash
        ps -fp $(pgrep -d" " -u jduser)

    docker commit jdownloader jdebug
    docker run -it --entrypoint=/bin/bash --name jdebug jdebug

## Remove not tagged images

    docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
