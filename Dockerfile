FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY :0

ENV USERNAME developer

WORKDIR /app

RUN apt update

RUN apt-get install -y --no-install-recommends \
    apt-transport-https \
    software-properties-common \
    fuse3 libfuse2 wget sudo

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo

USER $USERNAME

WORKDIR /home/$USERNAME

RUN wget -O /home/developer/gvim.appimage https://github.com/vim/vim-appimage/releases/download/v9.0.2181/GVim-v9.0.2181.glibc2.29-x86_64.AppImage

RUN chmod +x /home/developer/gvim.appimage

CMD "/home/developer/gvim.appimage"