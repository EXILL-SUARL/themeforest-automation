#!/usr/bin/env bash

# Update OS packages
apt update && apt upgrade -y

# Install ImageMagick
apt install imagemagick -y

# install markdown-to-document
npm i markdown-to-document -g
