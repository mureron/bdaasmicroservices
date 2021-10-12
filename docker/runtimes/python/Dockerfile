FROM rmuresano/bdaasjava:0_0_4 as builder
WORKDIR /home/legacy
COPY packages/ ./

# Miniconda Installation
RUN apt-get -y update && apt-get install -y bzip2
RUN bash miniconda-installer.sh -b -p /home/legacy/miniconda
RUN /home/legacy/miniconda/bin/pip install --upgrade pip && \
    /home/legacy/miniconda/bin/conda clean -p && \
    rm miniconda-installer.sh

FROM rmuresano/bdaasjava:0_0_4 
WORKDIR /home/legacy
COPY --from=builder /home/legacy/miniconda /home/legacy/miniconda
ENV PATH="$PATH:/home/legacy/miniconda/bin"

#/home/legacy/miniconda/bin/conda update -y -n base conda && \