# Parto de la imagen principal
FROM  runtimes/bdaasjupyter:0_0_1
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./

COPY packages/ ./

ENTRYPOINT ./startup-config.sh
