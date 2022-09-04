FROM debian:stable

RUN apt update && sudo apt upgrade -y

COPY . .

ENTRYPOINT ["/bin/bash", "/entry.sh"]

