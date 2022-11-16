#!/bin/sh

REPO="localhost"
IMAGE="helium-local-system"

podman run -it -p 8086:8086 -p 1880:1880 ${@} $REPO/$IMAGE
