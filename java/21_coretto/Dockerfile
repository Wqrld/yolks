FROM --platform=$TARGETOS/$TARGETARCH amazoncorretto:21.0.7-al2

LABEL author="Michael Parker" maintainer="parker@pterodactyl.io"
LABEL org.opencontainers.image.source="https://github.com/pterodactyl/yolks"
LABEL org.opencontainers.image.licenses=MIT

# Install dependencies using yum
RUN yum install -y \
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
    zip \
    unzip \
    which \
    bash \
    && yum clean all

# Install tini manually since it's not in yum by default
RUN curl -Lo /usr/bin/tini https://github.com/krallin/tini/releases/download/v0.19.0/tini \
    && chmod +x /usr/bin/tini

# Create user and set permissions
RUN useradd -m -d /home/container -s /bin/bash container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

STOPSIGNAL SIGINT

COPY --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]
