FROM debian:stable AS development

# Update package list
RUN apt update

# Create a layer
FROM debian:stable

# Update package list
RUN apt update

# Install packages
RUN apt install sudo curl -y

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash && apt install nodejs -y

# Install Python 3 and PIP
RUN sudo apt install python3 python3-pip -y

COPY install-dependencies.sh /tmp

RUN /tmp/install-dependencies.sh

# Create a temporary directory for processing and storing files and set it as ENV
ARG TMP_DIRNAME="directory"

ENV TMP_DIRNAME=$TMP_DIRNAME

ARG TMPDIR=/tmp/$TMP_DIRNAME-tmp/

ENV TMPDIR=$TMPDIR

RUN mkdir -p TMPDIR

# Copy executables to bin directory
COPY workflow /usr/local/bin
