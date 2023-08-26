#!/usr/bin/env bash

set -e

# Update OS packages
sudo apt update && sudo apt upgrade -y

# Install python-slugify
pip install python-slugify

# Install markdown-to-document
npm i markdown-to-document@"<1.0.0" -g

# Install Tera CLI
cargo install --git https://github.com/chevdor/tera-cli

# Install LicenseFinder
gem install license_finder

# Install packages
sudo apt install sudo jq curl zip imagemagick pandoc ffmpeg rsync -y
