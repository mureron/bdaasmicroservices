# Parto de la imagen principal
FROM  rmuresano/bdaaspyspark:0_0_4
LABEL maintainer="Ronal Muresano"

WORKDIR /home/legacy

COPY startup-config.sh ./

COPY packages/ ./

RUN apt-get -y update && apt-get install -y npm git
#RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && apt-get install -y nodejs && \
#    npm install -g configurable-http-proxy

RUN /home/legacy/miniconda/bin/conda install -c conda-forge nodejs
RUN /home/legacy/miniconda/bin/pip3 install --user asyncio-contextmanager

# Install Features (Variable Inspector)
RUN /home/legacy/miniconda/bin/pip install lckr-jupyterlab-variableinspector

ENTRYPOINT ./startup-config.sh
