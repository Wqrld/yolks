FROM        --platform=$TARGETOS/$TARGETARCH redis:8.4.0-bookworm

LABEL       author="Luc H" maintainer="luc@feroxhosting.nl"

RUN         useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
