#!/bin/sh

if [ "$1" == "startx" ]; then
    echo "Starting nework"
    docker network create \
      --driver=bridge \
      --attachable \
      --subnet=172.40.0.0/16 \
      --gateway=172.40.0.1 \
      network_frontend
    docker network create \
      --driver=bridge \
      --attachable \
      --subnet=172.42.0.0/16 \
      --gateway=172.42.0.1 \
      network_proxy
    docker network create \
      --driver=bridge \
      --attachable \
      --subnet=172.44.0.0/16 \
      network_db
elif [ "$1" == "stop" ]; then
    echo "Stopping network"
    docker network rm network_frontend
    docker network rm network_proxy
    docker network rm network_db
    docker network rm portainer_default
fi
