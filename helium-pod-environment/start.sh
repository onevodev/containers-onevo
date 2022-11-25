#!/bin/sh

set -e
# env vars
source .env

# start pod if stopped
[ -z "$(podman pod ps | grep -v CONTAINER | grep -w ${POD_NAME})" ] || (echo "A pod named ${POD_NAME} already exists!" ; exit 1)
podman pod start ${POD_NAME}
