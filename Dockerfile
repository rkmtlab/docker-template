# syntax=docker/dockerfile:1.2

FROM    nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04
ENV     DEBIAN_FRONTEND noninteractive

# add nvidia key
RUN     apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub \
        && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

# add libs
RUN     apt-get update && apt-get install -y \
        curl \
        git \
        build-essential \
        openssh-server \
        python3 \
        python3-distutils \
        python3-pip \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
COPY    requirements.txt        /tmp/requirements.txt
RUN     --mount=type=cache,mode=0755,target=/root/.cache pip install -r /tmp/requirements.txt \
        && rm /tmp/*
# set up expose port
WORKDIR /root
COPY    start.sh        /root/
ARG     PORT=2000
ENV     PORT    ${PORT}
EXPOSE  ${PORT}
WORKDIR /workspace
CMD ["/root/start.sh"]
