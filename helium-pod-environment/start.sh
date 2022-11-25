#!/bin/sh

set -e
# env vars
source .env

# start pod if stopped
[ -z "$(podman pod ps | grep -w ${POD_NAME} | grep -v CONTAINER)" ] || (echo "A pod named '${POD_NAME}' already exists!" ; exit 1)
podman pod start ${POD_NAME}
