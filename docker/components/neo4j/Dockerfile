# Parto de la imagen principal
FROM  rmuresano/bdaasjava:0_0_4
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./

COPY packages/ ./

ENTRYPOINT ./startup-config.sh
