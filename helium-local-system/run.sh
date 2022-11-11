#!/bin/sh

REPO="localhost"
IMAGE="test1"

podman run -it -p 8086:8086 -p 1880:1880 $REPO/$IMAGE
