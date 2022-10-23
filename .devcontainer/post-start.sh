#!/usr/bin/env bash

set -e

sudo apt update && sudo apt upgrade -y

sudo apt install tzdata -y

source install-dependencies.sh
