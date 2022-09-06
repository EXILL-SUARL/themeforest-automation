#!/usr/bin/env bash

# Update OS packages
apt update && apt upgrade -y

# Install Pandoc and its dependencies
apt install pandoc texlive-latex-recommended texlive-latex-extra -y

# Install ImageMagick
apt install imagemagick -y
