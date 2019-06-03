FROM bdaasspark:0_0_1
WORKDIR /home/legacy
COPY packages/ ./

ENV NVM_DIR /usr/local/nvm

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean libxrender1 ttf-ubuntu-font-family apt-utils \
    && rm -rf /var/lib/apt/lists/*

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

## install node and npm
#RUN /bin/bash -c "source /root/.nvm/nvm.sh" \
#    && nvm install node \
#    && nvm alias default node \
#    && nvm use default
#
## add node and npm to path so the commands are available
#ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
#ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


#WORKDIR /home/legacy/miniconda/bin
#RUN conda install jupyterlab
#RUN jupyter labextension install jupyterlab_bokeh @jupyter-widgets/jupyterlab-manager jupyter-leaflet
