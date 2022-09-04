FROM debian:stable

RUN apt update && sudo apt upgrade -y

RUN deps.sh

COPY . .

ENTRYPOINT ["/bin/bash", "/entry.sh"]

