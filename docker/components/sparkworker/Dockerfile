# Parto de la imagen principal
FROM  rmuresano/bdaasspark:0_0_4
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils iputils-ping

ENTRYPOINT ./startup-config.sh