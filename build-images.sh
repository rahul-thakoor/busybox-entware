#!/bin/bash
set -e

function build_and_push_image () {
  local BALENA_ARCH=$1
  local PLATFORM=$2

  TAG=$DOCKER_REPO/$PROJECT_NAME:$BALENA_ARCH-$VERSION

  echo "Building for $BALENA_ARCH, platform $PLATFORM, pushing to $TAG"
  
  docker buildx build . --pull \
      --build-arg BALENA_ARCH=$BALENA_ARCH \
      --platform $PLATFORM \
      --file Dockerfile.template \
      --tag $TAG --load

  echo "Publishing..."
  docker push $TAG
}

function create_and_push_manifest() {
   docker manifest rm $DOCKER_REPO/$PROJECT_NAME:latest || true
  docker manifest create $DOCKER_REPO/$PROJECT_NAME:latest \
  --amend $DOCKER_REPO/$PROJECT_NAME:aarch64-$VERSION \
  --amend $DOCKER_REPO/$PROJECT_NAME:armv7hf-$VERSION \
  --amend $DOCKER_REPO/$PROJECT_NAME:rpi-$VERSION \
  --amend $DOCKER_REPO/$PROJECT_NAME:amd64-$VERSION \

  docker manifest push --purge $DOCKER_REPO/$PROJECT_NAME:latest
}

# YOu can pass in a repo (such as a test docker repo) or accept the default
DOCKER_REPO=${1:-rahulthakoor}
VERSION=${2:-$(<VERSION)}
PROJECT_NAME="busybox-entware"

build_and_push_image "aarch64" "linux/arm64" 
build_and_push_image "armv7hf" "linux/arm/v7" 
build_and_push_image "rpi" "linux/arm/v6" 
build_and_push_image "amd64" "linux/amd64"
build_and_push_image "i386" "linux/386"

create_and_push_manifest