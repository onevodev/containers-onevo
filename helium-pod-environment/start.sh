#!/bin/sh

set -e
# env vars
source ./.env

# start pod if stopped
[ -z "$(podman pod ps | grep -w ${POD_NAME} | grep -v CONTAINER)" ] && (echo "Can't find a pod named '${POD_NAME}'!" ; exit 1)
podman pod start ${POD_NAME}
