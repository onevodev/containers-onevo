#!/bin/sh

# exit on error
set -e
# set image name
IMAGE="helium-local-system"
# build image
podman build -t $IMAGE .
# setup image
podman run -it --name $IMAGE localhost/$IMAGE /usr/local/bin/setup.sh
# commit image
podman commit -c "CMD=start-daemon.sh" $(podman ps -a | grep -w $IMAGE | awk -F " " '{print$1}') localhost/$IMAGE
# remove template
podman rm $(podman ps -a | grep -w $IMAGE | awk -F " " '{print$1}')
# done
echo "Done."
