FROM debian:stable AS development

# Update package list
RUN apt update

# Create a layer
FROM debian:stable

ENV CI=true

ENV LOAD_ENV=/usr/local/bin/.load_env

COPY features.sh /tmp

COPY install-dependencies.sh /tmp

COPY tests /tmp/tests

COPY shared-features /tmp/shared-features

RUN DEBIAN_FRONTEND=noninteractive /tmp/features.sh

# Create a temporary directory for processing and storing files and set it as ENV
ARG TMP_DIRNAME="directory"

ENV TMP_DIRNAME=$TMP_DIRNAME

ARG TMP_DIR=/tmp/$TMP_DIRNAME-tmp/

ENV TMP_DIR=$TMP_DIR

RUN mkdir -p TMP_DIR

# Copy executables to bin directory
COPY workflow /usr/local/bin

COPY runner /usr/local/bin
