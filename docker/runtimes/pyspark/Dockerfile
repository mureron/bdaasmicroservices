FROM rmuresano/bdaaspython:0_0_4 as builder
WORKDIR /home/legacy
COPY packages/ ./
ENV PATH="$PATH:/home/legacy/jre/bin"
ENV PATH="$PATH:/home/legacy/miniconda/bin"