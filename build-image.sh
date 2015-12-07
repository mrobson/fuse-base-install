DOCKER_IMAGE_NAME=mrobson/fuse-base-install
DOCKER_IMAGE_VERSION=6.2.1.84

docker rmi --force=true ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
docker build --force-rm=true --rm=true -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} .
