FROM ubuntu:20.04

ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" user \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user

## apt install prepare 
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn\/ubuntu/g' /etc/apt/sources.list
RUN apt update
ENV DEBIAN_FRONTEND noninteractive

## base tools
RUN apt install -y wget git
RUN apt install -y less

ENV TZ Asia/Shanghai

## sudo no password
RUN apt install -y sudo
RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

## yocto requires
RUN apt install -y python3


USER user
WORKDIR /home/user/


## entrypoint.sh
COPY entrypoint.sh .
RUN sudo chown user:user entrypoint.sh

ENTRYPOINT [ "bash","entrypoint.sh" ]