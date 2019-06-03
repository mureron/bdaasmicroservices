FROM ubuntu:latest
WORKDIR /home/legacy
COPY packages/ ./

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends bzip2 build-essential libssl1.0.0 libpam0g openssl autotools-dev libssl1.0-dev libpam0g-dev zlib1g-dev debhelper dh-autoreconf
RUN apt-get -y update && \
    apt-get install -y openssh-server sshpass whois net-tools bc  nano && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/legacy/shellinabox
RUN mkdir -p shellinaboxBin && autoreconf -i && ./configure --prefix=/home/legacy/shellinabox/shellinaboxBin/ && make && make install
ENV PATH="$PATH:/home/legacy/jre/bin"

WORKDIR /home/legacy
