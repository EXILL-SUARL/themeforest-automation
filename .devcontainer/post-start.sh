#!/usr/bin/env bash

set -e

sudo apt update && sudo apt upgrade -y

sudo apt install tzdata -y

echo "export PATH=$PATH:$PWD/workflow" >> ~/.bashrc

source ../shared-features/python.sh

source install-dependencies.sh
