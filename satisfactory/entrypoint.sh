#!/bin/bash -ue

# Install certificates and sudo
apt update && apt install -y ca-certificates sudo

# Map nobody to the desired UID/GID
usermod -u $PUID nobody
groupmod -g $PGID nogroup

# Mark start script and server binary executable
chmod +x /opt/game/Engine/Binaries/Linux/FactoryServer-Linux-Shipping
chmod +x /opt/game/FactoryServer.sh

# Create save directory
mkdir -p /data/FactoryGame/Saved
mkdir -p /data/Engine/Saved
mkdir -p /data/home
chown -R nobody:nogroup /data

# Create other writable directories needed by server
mkdir -p /opt/game/FactoryGame/Intermediate
chown -R nobody:nogroup /opt/game/FactoryGame/Intermediate

# Create directories in state directory
ln -f -s /data/FactoryGame/Saved /opt/game/FactoryGame/Saved
chown -R nobody:nogroup /opt/game/FactoryGame/Saved
ln -f -s /data/Engine/Saved /opt/game/Engine/Saved
chown -R nobody:nogroup /opt/game/Engine/Saved

# Start server as nobody
sudo -u nobody HOME=/data/home /opt/game/FactoryServer.sh -Port=$PORT