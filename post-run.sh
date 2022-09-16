#!/usr/bin/env bash

# Update OS packages
sudo apt update && apt upgrade -y

# Install ImageMagick
sudo apt install imagemagick -y

# install markdown-to-document
npm i markdown-to-document@"<1.0.0" -g
