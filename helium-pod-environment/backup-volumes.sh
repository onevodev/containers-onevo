#!/bin/sh

set -e
# env vars
source .env

for volume in $VOLUMES; do

	mkdir -p $BAK_DIR/$volume
	podman volume export $volume -o $BAK_DIR/$volume/$volume-$(date -I).tar

done
