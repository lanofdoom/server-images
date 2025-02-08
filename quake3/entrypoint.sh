#!/bin/bash -ue

# Install certificates and sudo
apt update && apt install -y sudo wget

# Download pak0.pk3
wget -O /opt/game/baseq3/pak0.pk3 https://github.com/nrempel/q3-server/raw/master/baseq3/pak0.pk3
echo "7ce8b3910620cd50a09e4f1100f426e8c6180f68895d589f80e6bd95af54bcae /opt/game/baseq3/pak0.pk3" | sha256sum -c

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
    +exec mapcycle.cfg
