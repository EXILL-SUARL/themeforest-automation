FROM debian:stable

# install packages
RUN apt install sudo curl -y

# install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash && apt install nodejs -y

# create a temporary directory for processing and storing files and set it as ENV
ARG TMPDIR="/tmp/temporary-dir"

ENV TMPDIR=$TMPDIR

RUN mkdir $TMPDIR

COPY workflow /usr/local/bin

# execute post-run script
COPY post-run.sh /tmp

ENTRYPOINT [ "/tmp/post-run.sh" ]
