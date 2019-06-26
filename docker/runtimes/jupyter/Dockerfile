FROM rmuresano/bdaasspark:0_0_1
WORKDIR /home/legacy
COPY packages/ ./


RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean libxrender1 ttf-ubuntu-font-family apt-utils \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.1

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash

RUN /bin/bash -c "source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default"

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

WORKDIR /home/legacy/miniconda/bin
RUN conda install jupyterlab
RUN apt-get -y update && apt-get -y install gcc python-dev && pip install cassandra-driver
RUN pip install pandas numpy
RUN jupyter labextension install jupyterlab_bokeh @jupyter-widgets/jupyterlab-manager jupyter-leaflet

WORKDIR /home/legacy
