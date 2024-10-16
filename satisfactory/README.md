# LAN of DOOM Satisfactory Server

# Installation

Run `docker pull ghcr.io/lanofdoom/satisfactory-server:latest`

# Development

```
bazel run //:image_tarball && docker run --rm -it -p 7777:7777 -p 7777:7777/udp satisfactory-server:bazel
```
