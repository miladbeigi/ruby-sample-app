#!/bin/bash

docker exec -it redis-1 \
        redis-cli --cluster \
        create \
        172.38.0.11:6379 \
        172.38.0.12:6379 \
        172.38.0.13:6379 \
        172.38.0.14:6379 \
        172.38.0.15:6379 \
        172.38.0.16:6379 \
        --cluster-replicas 1 \
        --cluster-yes
