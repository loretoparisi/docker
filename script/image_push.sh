#
# Docker Image Deploy Script
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @2017 Loreto Parisi (loretoparisi at gmail dot com)
#

[ -z "$DOCKER_USER" ] | [ -z "$DOCKER_IMAGE" ] && { echo "Missing environment. Please set DOCKER_IMAGE and DOCKER_USER first"; exit 1; }
[ -z "$1" ] && { echo "Usage: $0 $1"; exit 1; }

docker login
docker tag $DOCKER_IMAGE $DOCKER_USER/$DOCKER_IMAGE:$1
docker push $DOCKER_USER/$DOCKER_IMAGE:$1