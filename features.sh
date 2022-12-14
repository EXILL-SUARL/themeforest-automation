#!/usr/bin/env bash

set -e

# Update package list
apt update

# Install packages
apt install sudo curl procps build-essential -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | bash && apt install nodejs -y

# Install Rustup
RUSTPUP_PATH=/root/.cargo/env

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source $RUSTPUP_PATH

echo 'export PATH=/root/.cargo/bin:$PATH' >> $LOAD_ENV

# Install Ruby
RUBY_PATH=/usr/local/rvm/scripts/rvm

curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

curl -sSL https://get.rvm.io | bash -s stable --ruby="3.0"

source $RUBY_PATH

echo "source $RUBY_PATH" >> $LOAD_ENV

# Install Python 3 and PIP (both os-provided/3.11)
apt install python3 python3-pip -y

source /tmp/shared-features/python.sh

source /tmp/install-dependencies.sh
