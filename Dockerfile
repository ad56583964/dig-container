FROM ubuntu:20.04

ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user

RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn\/ubuntu/g' /etc/apt/sources.list
## other

RUN apt update

ENV DEBIAN_FRONTEND noninteractive

RUN apt install -y wget git

RUN apt install -y less

ENV TZ Asia/Shanghai
# qemu compile prepare
RUN apt install -y tzdata
RUN apt install -y python3
RUN apt install -y python3-pip
RUN apt install -y ninja-build
RUN apt install -y libglib2.0-0
RUN apt install -y meson
RUN apt install -y sudo
RUN apt install -y libglib2.0-dev
RUN apt install -y flex
RUN apt install -y bison
# debug
RUN apt install -y strace
RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# copy tool
RUN sudo apt install -y rsync

# create user
USER user
WORKDIR /home/user/

# set proxy
ENV http_proxy=http://192.168.137.1:7890
ENV https_proxy=http://192.168.137.1:7890
ENV ftp_proxy=http://192.168.137.1:7890
ENV ALL_PROXY=socks5://192.168.137.1:7889
ENV all_proxy=socks5://192.168.137.1:7889

# archive 
# - download source codes
RUN mkdir -p /home/user/archive
WORKDIR /home/user/archive

###################
# git clone begin #
#-----------------#
RUN git clone -v https://github.com/gcc-mirror/gcc.git -b releases/gcc-12.3.0

#-----------------#
# git clone   end #
###################

###################
# build     begin #
#-----------------#
WORKDIR /home/user/archive/gcc

#-----------------#
# build       end #
###################

WORKDIR /home/user/
RUN mkdir -p container-temp
RUN rsync -av archive/* container-temp && rm -rf archive/*

###################
# append    start #
#-----------------#

RUN sudo apt install -y time

#-----------------#
# append      end #
###################


# all changes in archive move to container-temp
# to prepare expose them to the host next

COPY entrypoint.sh .
RUN sudo chown user:user entrypoint.sh

ENTRYPOINT [ "bash","entrypoint.sh" ]