# LAN of DOOM Quake 3 Server
Docker image for a Quake 3 Server as used by the LAN of DOOM.

# Installation
Run ``docker pull ghcr.io/lanofdoom/quake3-server:latest``

# Environmental Variables
``Q3_FRAGLIMIT`` The UDP and TDP port used to run the server. ``20`` by default.

``Q3_HOSTNAME`` The name of the server listed when joining the server.

``Q3_PASSWORD`` The password users must enter in order to join the server.

``Q3_SPEED`` The default player movement speed. ``320`` by default.

``RCON_PASSWORD`` The rcon password for the server.

# Known Issues
The server currently will not start if the container is run with
``--network=host``. As a workaround, you should instead manually expose the
ports when launching it (for example, if using the default ports you would add
the arguments ``-p 27960:27960/udp`` if you want them to map it onto the same
ports on the host).