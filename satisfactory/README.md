# LAN of DOOM Satisfactory Server
Docker image for a Satisfactory Server as used by the LAN of DOOM.

# Installation
Run ``docker pull ghcr.io/lanofdoom/satisfactory-server:latest``

# Volumes
Persistent server state (such as save games) is saved to ``/data`` inside the
container. In order to ensure the server state is persisted across image
updates, add the argument ``-v <LocalPath>:/data`` when starting the container.

# Environmental Variables
``PUID`` The user ID used to run the server. ``1000`` by default.

``PGID`` The group ID used to run the server. ``1000`` by default.

# Known Issues
The server currently will not start if the container is run with
``--network=host``. As a workaround, you should instead manually expose the
ports when launching it (for example, if using the default ports you would add
the arguments ``-p 7777:7777 -p 7777:7777/udp`` if you want them to map onto
the same ports on the host).