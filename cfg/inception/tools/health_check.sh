#!/bin/bash

echo "Checking health of containers..."

for service in nginx wordpress mariadb; do
    STATUS=$(docker inspect --format='{{.State.Health.Status}}' "${service}_container_name" 2>/dev/null)
    if [ "$STATUS" == "healthy" ]; then
        echo "$service is healthy."
    else
        echo "$service is not healthy (status: $STATUS)."
    fi
done
