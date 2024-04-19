FROM        --platform=$TARGETOS/$TARGETARCH eclipse-temurin:21-jdk-jammy

LABEL       author="Wqrld" maintainer="luc@feroxhosting.nl"

LABEL       org.opencontainers.image.source="https://github.com/wqrld/yolks"
LABEL       org.opencontainers.image.licenses=MIT

RUN         apt-get update -y \
			&& apt-get install -y curl ca-certificates openssl git tar sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 \
			&& useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
