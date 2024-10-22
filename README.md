# LAN of DOOM Server Images
This repository contains the definitions for the Docker containers of the
various game servers used by the LAN of DOOM.

Documentation for each server as well as how to fetch it can be found in the
README.md of each server's folder.

On our own servers, we typically run
[Watchtower](https://hub.docker.com/r/containrrr/watchtower) and rely on it to
automatically pull down the latest versions of these images. We configure our
servers to poll every 5 minutes for new images.

We run Watchtower with the following Docker command.

```
docker run -d \
    --name watchtower \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e WATCHTOWER_CLEANUP=true \
    -e WATCHTOWER_POLL_INTERVAL=300 \
    containrrr/watchtower
```