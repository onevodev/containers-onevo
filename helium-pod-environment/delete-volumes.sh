#!/bin/sh

# env vars
source ./.env

echo "Deleting..."
for volume in $VOLUMES; do
	podman volume rm $volume
done
