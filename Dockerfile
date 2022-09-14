FROM debian:stable

RUN apt update && apt upgrade -y

RUN apt install sudo

COPY deps.sh /tmp

RUN bash /tmp/deps.sh

COPY workflow /usr/local/bin
