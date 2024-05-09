FROM archlinux:base

ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user

RUN sed -i '1iServer = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist

## other

RUN pacman -Sy

RUN pacman -S --noconfirm wget git

RUN pacman -Sy less
# RUN wget https://github.com/CyberShadow/aconfmgr.git

WORKDIR /home/user/workdir
# Everything after this point will run as the python user with a specific UID / GID