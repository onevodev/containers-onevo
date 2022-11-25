#!/bin/sh

set -e
# env vars
source .env

for volume in $VOLUMES; do
	[ -z "$(podman volume ls | grep -w $volume | grep -v CONTAINER)" ] && echo "Can't seem to find a volume named '$volume'!" || ( \
	echo "Backing up $volume in $BAK_DIR/$volume..."
	[ -d $BAK_DIR/$volume ] || mkdir -p $BAK_DIR/$volume
	podman volume export $volume -o $BAK_DIR/$volume/$volume-$(date -Iminutes | sed 's|:|-|g; s|+|-|g').tar
	)
done
