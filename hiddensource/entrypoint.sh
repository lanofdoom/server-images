#!/bin/bash -ue

# Install auth_by_steam_group and server dependencies
dpkg --add-architecture i386 && apt-get update && apt-get install -y ca-certificates wine wine32 xvfb

# Set MOTD
[ -z "${HIDDEN_MOTD}" ] || echo "${HIDDEN_MOTD}" > /opt/game/hidden/motd.txt

#  Hack to make auth plugin load properly
cp /opt/game/hidden/addons/sourcemod/extensions/auth_by_steam_group.ext.2.ep1.dll /opt/game/hidden/addons/sourcemod/extensions/auth_by_steam_group.ext.dll

# Generate mapcycle
ls /opt/game/hidden/maps/*.bsp | grep -v tutorial | sed -e 's/.*\/\([^\/]*\).bsp/\1/' > /opt/game/hidden/cfg/mapcycle.txt

# Touch this file to workaround an issue in sourcemod
touch /opt/game/hidden/addons/sourcemod/configs/maplists.cfg

# Touch these files to prevent sourcemod from creating them and overriding
# values sent in server.cfg
touch /opt/game/hidden/cfg/sourcemod/mapchooser.cfg
touch /opt/game/hidden/cfg/sourcemod/rtv.cfg

# Update server config file
cp /opt/game/hidden/cfg/templates/server.cfg /opt/game/hidden/cfg/server.cfg
echo "// Added by entrypoint.sh" >> /opt/game/hidden/cfg/server.cfg
echo "hostname \"$HIDDEN_HOSTNAME\"" >> /opt/game/hidden/cfg/server.cfg

# Set terminal
export TERM=xterm

# Remove the old display lock file
rm -f /tmp/.X99-lock

# Start display server
Xvfb :99 -screen 0 800x600x16 &
sleep 10s

# Configure wine
export DISPLAY=:99
export WINEPREFIX=$(mktemp -d)
export WINEARCH=win32

# CD into game directory
cd /opt/game

# Redirect console.log to stdout
ln -sf /dev/stdout /opt/game/hidden/console.log

# Start game
wine start /wait srcds.exe \
    -game hidden \
    -port "$HIDDEN_PORT" \
    -strictbindport \
    -console \
    -condebug \
    -tickrate 100 \
    +ip 0.0.0.0 \
    +map "$HIDDEN_MAP" \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$HIDDEN_PASSWORD" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"
