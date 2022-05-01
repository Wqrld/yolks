FROM        --platform=$TARGETOS/$TARGETARCH node:18-bullseye-slim

LABEL       author="Matthew Penner" maintainer="matthew@pterodactyl.io"

RUN         apk add --update --no-cache ca-certificates curl ffmpeg git openssl sqlite tar tzdata \
	&& adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]
