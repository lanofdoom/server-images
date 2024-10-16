# LAN of DOOM SourceForts Classic Server
Docker image for a private, preconfigured private SourceForts Classic server as
used by the LAN of DOOM.

# Installation
Run ``docker pull ghcr.io/lanofdoom/sourceforts-server:latest``

# Installed Addons
*  LAN of DOOM Authenticate by Steam Group
*  MetaMod:Source
*  SourceMod

# Environmental Variables
``SF_HOSTNAME`` The name of the server as listed in Valve's server browser.

``SF_PASSWORD`` The password users must enter in order to join the server.

``SF_MAP`` The first map to run on the server. ``sf_skywalk`` by default.

``SF_MOTD`` The MOTD to use for the server.

``SF_PORT`` The port to use for the server. ``27015`` by default.

``RCON_PASSWORD`` The rcon password for the server.

``STEAM_GROUP_ID`` The Steam group to use for the allowlist of users joining the
server.

``STEAM_API_KEY`` The [Steam API key](https://steamcommunity.com/dev/apikey) to
use for the group membership checks with the Steam's Web API.
