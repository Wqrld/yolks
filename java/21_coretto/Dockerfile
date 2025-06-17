FROM        --platform=$TARGETOS/$TARGETARCH amazoncorretto:21.0.7

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

LABEL       org.opencontainers.image.source="https://github.com/pterodactyl/yolks"
LABEL       org.opencontainers.image.licenses=MIT

# Install required packages
RUN dnf install -y \
        shadow-utils \
        curl \
        lsof \
        ca-certificates \
        openssl \
        git \
        tar \
        sqlite \
        fontconfig \
        tzdata \
        iproute \
        freetype \
        tini \
        zip \
        unzip \
    && dnf clean all

# Setup user and working directory
RUN useradd -m -d /home/container -s /bin/bash container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
