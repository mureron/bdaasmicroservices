FROM runtimes/bdaasjava:0_0_1
WORKDIR /home/legacy
COPY packages/ ./

# Miniconda Installation
RUN bash miniconda-installer.sh -b -p /home/legacy/miniconda && \
    /home/legacy/miniconda/bin/conda update -y -n base conda && \
    /home/legacy/miniconda/bin/pip install --upgrade pip && \
    /home/legacy/miniconda/bin/conda clean -p && \
    rm miniconda-installer.sh
ENV PATH="$PATH:/home/legacy/miniconda/bin"