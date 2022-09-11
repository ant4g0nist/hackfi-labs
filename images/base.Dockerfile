FROM codercom/enterprise-base:ubuntu

LABEL AUTHOR="ant4g0nist"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV TZ=Europe/Amsterdam
ENV LC_ALL=C.UTF-8
ENV DISPLAY=:0.0

USER root
# Allow passwordless sudo for etheno
RUN echo 'coder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# install essentials
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash-completion \
    python3 \
    libpython3-dev \
    python3-pip \
    python3-setuptools \
    git \
    build-essential \
    software-properties-common \
    locales-all locales \
    libudev-dev \
    gpg-agent \
    net-tools  \
    xfce4 xfce4-terminal \
    novnc tigervnc-standalone-server \
    vim-tiny firefox && cp /usr/share/novnc/vnc.html /usr/share/novnc/index.html \
    && echo "UI.connect()" >> /usr/share/novnc/app/ui.js \
    && sed -i 's/off/remote/g' /usr/share/novnc/app/ui.js \ 
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt-get update && apt-get install -y \
#     python3.7 \ 
#     python3.7-dev

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get install -y nodejs

WORKDIR /home/coder
ENV SHELL=/bin/bash

# install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh