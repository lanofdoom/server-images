#!/bin/bash -ue

# Install auth_by_steam_group dependencies
apt-get update && apt-get install -y ca-certificates libcurl4

# Set MOTD
[ -z "${SF_MOTD}" ] || echo "${SF_MOTD}" > /opt/game/sfclassic/motd.txt

# Generate mapcycle here to cut down on image build time and space usage.
ls /opt/game/sfclassic/maps/*.bsp | grep -v test | sed -e 's/.*\/\([^\/]*\).bsp/\1/' > /opt/game/sfclassic/cfg/mapcycle.txt

# Touch this file to workaround an issue in sourcemod
touch /opt/game/sfclassic/addons/sourcemod/configs/maplists.cfg

# Touch these files to prevent sourcemod from creating them and overriding
# values sent in server.cfg
touch /opt/game/sfclassic/cfg/sourcemod/mapchooser.cfg
touch /opt/game/sfclassic/cfg/sourcemod/rtv.cfg

# Update server config files
cp /opt/game/sfclassic/cfg/templates/server.cfg /opt/game/sfclassic/cfg/server.cfg
echo "// Added by entrypoint.sh" >> /opt/game/sfclassic/cfg/server.cfg
echo "hostname \"$SF_HOSTNAME\"" >> /opt/game/sfclassic/cfg/server.cfg
echo "hostname \"$SF_HOSTNAME\"" > /opt/game/sfclassic/cfg/phase_build.cfg
echo "hostname \"$SF_HOSTNAME\"" > /opt/game/sfclassic/cfg/phase_combat.cfg

# Mark srcds_linux as executable
chmod +x /opt/game/srcds_linux

# Call srcds_linux instead of srcds_run to avoid restart logic
LD_LIBRARY_PATH="/opt/game:/opt/game/bin:${LD_LIBRARY_PATH:-}" /opt/game/srcds_linux \
    -game sfclassic \
    -port "$SF_PORT" \
    -strictbindport \
    -usercon \
    +ip 0.0.0.0 \
    +map "$SF_MAP" \
    +maxplayers 32 \
    +rcon_password "$RCON_PASSWORD" \
    +sv_password "$SF_PASSWORD" \
    +sm_auth_by_steam_group_group_id "$STEAM_GROUP_ID" \
    +sm_auth_by_steam_group_steam_key "$STEAM_API_KEY"