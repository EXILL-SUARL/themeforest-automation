FROM debian:stable

RUN apt update && apt upgrade -y

RUN apt install sudo curl -y

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash && apt install nodejs -y

COPY deps.sh /tmp

RUN bash /tmp/deps.sh

COPY workflow /usr/local/bin
