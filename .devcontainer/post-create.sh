#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

sudo apt install tzdata

bash post-run.sh
