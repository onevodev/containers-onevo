#!/bin/sh

set -e
# env vars
source .env

# start pod if stopped
[ -z "$(podman pod ps | grep -v CONTAINER | grep -w ${POD_NAME})" ] && (echo "Can't find pod named ${POD_NAME}!" ; exit 1)
podman pod stop ${POD_NAME}
