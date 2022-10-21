#!/usr/bin/env bash

set -e

# update OS packages
sudo apt update && sudo apt upgrade -y

# install markdown-to-document
npm i markdown-to-document@"<1.0.0" -g

# install packages
sudo apt install sudo curl zip imagemagick -y
