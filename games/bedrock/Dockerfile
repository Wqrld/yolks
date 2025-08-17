##
## Minecraft Bedrock Edition – Pterodactyl Yolk
## Ubuntu base, no arm64/box64, no healthcheck/monitor
##

FROM --platform=$TARGETOS/$TARGETARCH ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/pterodactyl/yolks"
LABEL org.opencontainers.image.licenses=MIT

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl unzip jq openssl ca-certificates tzdata iproute2 gnupg \
  && useradd -d /home/container -m container \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/container

## set-property is no longer required; server.properties is not auto-managed
## mc-server-runner removed; server is executed directly

# Copy Bedrock setup script
COPY ./bedrock-entry.sh /opt/bedrock-entry.sh
RUN chmod +x /opt/bedrock-entry.sh

USER container
ENV USER=container HOME=/home/container \
    VERSION=LATEST

COPY ./entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]
