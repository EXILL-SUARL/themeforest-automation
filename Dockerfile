FROM debian:stable AS development

# Update package list
RUN apt update

# Create a layer
FROM debian:stable

COPY features.sh /tmp

COPY install-dependencies.sh /tmp

RUN DEBIAN_FRONTEND=noninteractive /tmp/features.sh

# Create a temporary directory for processing and storing files and set it as ENV
ARG TMP_DIRNAME="directory"

ENV TMP_DIRNAME=$TMP_DIRNAME

ARG TMPDIR=/tmp/$TMP_DIRNAME-tmp/

ENV TMPDIR=$TMPDIR

RUN mkdir -p TMPDIR

# Copy executables to bin directory
COPY workflow /usr/local/bin
