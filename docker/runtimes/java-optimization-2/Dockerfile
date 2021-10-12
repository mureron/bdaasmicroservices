FROM ubuntu:16.04 as builder
WORKDIR /home/legacy
COPY packages/ ./
RUN apt-get -y update && apt-get install -y bzip2 build-essential libssl1.0.0 libpam0g openssl \
    && apt-get install -y autotools-dev libssl-dev libpam0g-dev zlib1g-dev debhelper dh-autoreconf \
    && apt-get install -y openssh-server sshpass whois net-tools bc  nano && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /home/legacy/shellinabox
RUN mkdir -p shellinaboxBin && autoreconf -i && ./configure --prefix=/home/legacy/shellinabox/shellinaboxBin/ && make && make install

FROM ubuntu:16.04
WORKDIR /home/legacy
COPY --from=builder /home/legacy/jre /home/legacy/jre
COPY --from=builder /home/legacy/shellinabox/ /home/legacy/shellinabox/
ENV PATH="$PATH:/home/legacy/jre/bin"

