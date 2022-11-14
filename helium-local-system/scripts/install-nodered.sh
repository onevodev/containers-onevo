#!/bin/sh

# install/update nodered
useradd -s /bin/sh -m -d /home/nodered nodered
curl -sSL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered > /root/node-red-script.sh
# fix for running in container
sed -i 's/$SUDO/sudo/g' /root/node-red-script.sh
# exec
chmod 755 /root/node-red-script.sh
exec /root/node-red-script.sh --node18 --confirm-root --confirm-install --skip-pi --no-init --nodered-user=nodered
# fix perms
chown -R nodered:nodered /home/nodered
