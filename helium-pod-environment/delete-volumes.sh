#!/bin/sh

# env vars
source .env

for volume in $VOLUMES; do
	podman volume rm $volume
done
