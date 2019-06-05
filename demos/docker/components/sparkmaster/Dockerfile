# Parto de la imagen principal
FROM  rmuresano/bdaasspark:0_0_1
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./

ENTRYPOINT ./startup-config.sh
