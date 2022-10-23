#!/usr/bin/env bash

set -e

# Update package list
apt update

# Install packages
apt install sudo curl procps -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | bash && apt install nodejs -y

# Install Rustup
RUSTPUP_PATH=$HOME/.cargo/env

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source $RUSTPUP_PATH && echo "source $RUSTPUP_PATH" >> $HOME/.bashrc

# Install Python 3 and PIP
apt install python3 python3-pip -y

source /tmp/install-dependencies.sh
