FROM debian:stable

RUN apt update && apt upgrade -y

RUN apt install sudo curl -y

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash && apt install nodejs -y

# create a temporary directory for processing and storing files
ARG TMPDIR="/tmp/temporary-dir"

ENV TMPDIR=$TMPDIR

RUN mkdir $TMPDIR

COPY post-run.sh /tmp

COPY workflow /usr/local/bin

ENTRYPOINT [ "/tmp/post-run.sh" ]
