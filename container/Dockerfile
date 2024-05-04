FROM ubuntu:22.04

ARG UID=1000
ARG GID=1000

RUN apt update -y
RUN apt install sudo -y

RUN groupadd -g "${GID}" user \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" user

RUN usermod -aG sudo user
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt install ninja-build -y
RUN apt install python3 -y

USER user

COPY ./run.sh /opt/run.sh

RUN bash /opt/run.sh

WORKDIR /home/user/workdir
# Everything after this point will run as the python user with a specific UID / GID