FROM        --platform=$TARGETOS/$TARGETARCH node:22-bullseye-slim

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping tini cmake \
            && useradd -m -d /home/container container

RUN         npm install typescript ts-node @types/node --location=global

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL  SIGINT

COPY        ./../entrypoint.sh /entrypoint.sh
ENTRYPOINT  [ "/usr/bin/tini", "-g", "--" ]
CMD         [ "/bin/bash", "/entrypoint.sh" ]
