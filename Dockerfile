FROM debian:stable

RUN apt update && apt upgrade -y

COPY deps.sh /tmp

RUN bash /tmp/deps.sh

COPY workflow /usr/local/bin
