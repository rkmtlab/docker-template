# ** change version of cuda, ubuntu on the basis of your machine
FROM    nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04
ENV     DEBIAN_FRONTEND noninteractive

# add nvidia key
RUN     apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub \
        && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

# add libs
RUN     apt-get update && apt-get install -y \
        curl \
        git \
        vim \
        build-essential \
        openssh-server \
        python3 \
        python3-distutils \
        python3-pip \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
COPY    requirements.txt        /tmp/requirements.txt
RUN     pip install --no-cache-dir -r /tmp/requirements.txt \
        && rm /tmp/*

USER root
SHELL ["/bin/bash", "-c"]
RUN mkdir -p ~/.ssh

# ** change github username and delete $ and {}
RUN curl -s https://github.com/${GITHUB_USERNAME}.keys >>  ~/.ssh/authorized_keys

WORKDIR /root/workspace

RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

