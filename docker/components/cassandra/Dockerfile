FROM  rmuresano/bdaasjava:0_0_4
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./
COPY packages/ ./

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils iputils-ping

ENTRYPOINT ./startup-config.sh
