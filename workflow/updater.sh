#!/usr/bin/env bash

set -e

# Update OS packages
sudo apt update && apt upgrade -y

# Update NPM packages
npm i markdown-to-document@"<1.0.0" -g
