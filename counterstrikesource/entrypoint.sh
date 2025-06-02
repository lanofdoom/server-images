#!/bin/bash -ue

# Install server and auth_by_steam_group dependencies
dpkg --add-architecture i386 && apt-get update && apt-get install -y lib32gcc-s1 ca-certificates libcurl4:i386 libstdc++6:i386

# Set MOTD
[ -z "${CSS_MOTD}" ] || echo "${CSS_MOTD}" > /opt/game/cstrike/motd.txt

# Generate mapcycle here to cut down on image build time and space usage.
ls /opt/game/cstrike/maps/*.bsp | grep -v test | sed -e 's/.*\/\([^\/]*\).bsp/\1/' > /opt/game/cstrike/cfg/mapcycle.txt

# Touch this file to workaround an issue in sourcemod
touch /opt/game/cstrike/addons/sourcemod/configs/maplists.cfg

# Touch these files to prevent sourcemod from creating them and overriding
# values sent in server.cfg
touch /opt/game/cstrike/cfg/sourcemod/mapchooser.cfg
touch /opt/game/cstrike/cfg/sourcemod/rtv.cfg

# Update server config file
cp /opt/game/cstrike/cfg/templates/server.cfg /opt/game/cstrike/cfg/server.cfg
echo "// Added by entrypoint.sh" >> /opt/game/cstrike/cfg/server.cfg
echo "hostname \"$CSS_HOSTNAME\"" >> /opt/game/cstrike/cfg/server.cfg

# Mark srcds_linux as executable
chmod +x /opt/game/srcds_linux

# cd into server directory
cd /opt/game

# Call srcds_linux instead of srcds_run to avoid restart logic
LD_LIBRARY_PATH="/opt/game:/opt/game/bin:${LD_LIBRARY_PATH:-}" /opt/game/srcds_linux \
    -game cstrike \
    -port "$CSS_PORT" \
    -strictbindport \
    -usercon \
    -tickrate 100 \
    +ip 0.0.0.0 \
    +map "$CSS_MAP" \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$CSS_PASSWORD" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"
