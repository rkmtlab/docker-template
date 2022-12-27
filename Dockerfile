FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04 

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub && \
        apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    build-essential \
    python3 \
    python3-distutils \
    python3-pip

RUN pip install -r requirements.txt

WORKDIR /root
COPY start.sh /root/

ARG PORT=2000
ENV PORT ${PORT}
EXPOSE ${PORT}

WORKDIR /workspace
CMD ["/root/start.sh"]