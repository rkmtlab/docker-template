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
RUN     pip install --no-cache-dir -r /tmp/requirements.txt \
        && rm /tmp/*

# create guest user
RUN     mkdir /var/run/sshd
RUN     useradd -m guest
RUN     passwd -d guest
RUN     sed -ri 's/^#?PermitEmptyPasswords\s+.*/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN     sed -ri 's/^#?UsePAM\s+.*/UsePAM no/' /etc/ssh/sshd_config
RUN     sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV     NOTVISIBLE      "in users profile"
RUN     echo "export VISIBLE=now" >> /etc/profile
ENTRYPOINT      ["/usr/sbin/sshd"]

# set up expose port
WORKDIR /root
COPY    start.sh        /root/
ARG     PORT=2000
ENV     PORT    ${PORT}
EXPOSE  ${PORT}
WORKDIR /workspace
CMD     ["-D"]
