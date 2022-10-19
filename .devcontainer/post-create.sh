#!/usr/bin/env bash

set -e

sudo apt update && sudo apt upgrade -y

sudo apt install tzdata

sudo bash post-run.sh
