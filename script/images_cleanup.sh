#!/bin/bash
# Docker images clean up
# Using at your own risk!
#
echo "Removing [exited] images..."
docker rm $(docker ps -q -f 'status=exited')

echo "Removing [dangling] images..."
docker rmi $(docker images -q -f "dangling=true")

echo "Removing <none> images..."
sudo docker images -a | grep none | awk '{ print $3; }' | xargs sudo docker rmi

echo "Done."