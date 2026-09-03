FROM        --platform=$TARGETOS/$TARGETARCH node:24-trixie-slim

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping cmake pkg-config build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev \
            && useradd -m -d /home/container container

RUN apt-get -y install libxcb-shm0 \                     
         libx11-xcb1 \                                 
         libxrandr2 \                                  
         libxcomposite1 \                              
         libxcursor1 \                                 
         libxdamage1 \                                 
         libxi6 \                                      
         libxfixes3 \                                  
         libgtk-3-0t64 \                               
         libpangocairo-1.0-0 \                         
         libpango-1.0-0 \                              
         libatk1.0-0t64 \                              
         libcairo-gobject2 \                           
         libcairo2 \                                   
         libgdk-pixbuf-2.0-0 \                         
         libxrender1 \
         libnspr4

RUN         npm install npm@latest typescript ts-node @types/node --location=global

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
