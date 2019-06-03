# Parto de la imagen principal
FROM  runtimes/bdaasjupyter:0_0_1
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

RUN /bin/mkdir -p volumen/data

COPY startup-config.sh ./

ENTRYPOINT ./startup-config.sh
