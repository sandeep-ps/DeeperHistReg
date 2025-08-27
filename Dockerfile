FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
    libopenblas-base \
    python3 \
    python3-pip \
    libgomp1 \
    libvips \
    libcrypto++ \
    python3-openslide \ 
    ffmpeg \
    libsm6 \
    libxext6 \
    ca-certificates \
    curl \
    build-essential \
    python3-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

CMD nvidia-smi 

RUN apt-get update && apt-get install -y python3 python3-pip python3.10-venv wget zip ca-certificates build-essential python3-dev libffi-dev
COPY ./deeperhistreg /src/deeperhistreg/
COPY ./deeperhistreg_params /src/deeperhistreg_params/
COPY ./requirements.txt /src/requirements.txt
RUN python3 -m venv /opt/venv/DeeperHistReg
RUN source /opt/venv/DeeperHistReg/bin/activate
# Update pip and install certificates before installing requirements
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r ./src/requirements.txt

ENTRYPOINT ["python3", "/src/deeperhistreg/run.py"]


