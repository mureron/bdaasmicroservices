FROM  runtimes/bdaasjava:0_0_1
LABEL maintainer="Radiatus team"

WORKDIR /home/legacy

COPY startup-config.sh ./
COPY packages/ ./

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils iputils-ping

ENTRYPOINT ./startup-config.sh
