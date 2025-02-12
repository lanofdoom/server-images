#!/bin/bash -ue

# Install certificates and sudo
apt update && apt install -y sudo

# Mark server as executable
chmod +x /opt/game/ioq3ded.x86_64

# Create home directory
mkdir -p /data/home
chown -R nobody:nogroup /data

# Launch Server
sudo -u nobody HOME=/data/home /opt/game/ioq3ded.x86_64 \
    +set dedicated 1 \
    +set rconpasswword $RCON_PASSWORD \
    +set sv_hostname $Q3_HOSTNAME \
    +set fraglimit $Q3_FRAGLIMIT \
    +set g_speed $Q3_SPEED \
    +set g_password $Q3_PASSWORD \
    +set sv_fps 125 \
    +set sv_minrate 99999 \
    +set sv_maxrate 99999 \
    +exec mapcycle.cfg
