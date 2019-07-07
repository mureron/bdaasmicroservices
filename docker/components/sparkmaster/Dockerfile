# Parto de la imagen principal
FROM  rmuresano/bdaasspark:0_0_4
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./

ENTRYPOINT ./startup-config.sh
