#!/usr/bin/env bash

set -e

# Update OS packages
sudo apt update && sudo apt upgrade -y

# Install python-slugify
pip Install python-slugify

# Install markdown-to-document
npm i markdown-to-document@"<1.0.0" -g

# Install Tera CLI
cargo install --git https://github.com/chevdor/tera-cli

# Install LicenseFinder
gem install licenseFinder

# Install packages
sudo apt install sudo curl zip imagemagick -y
