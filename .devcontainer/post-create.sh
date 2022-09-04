#!/usr/bin/env bash

sudo apt update && sudo apt -y upgrade

sudo apt install tzdata

/bin/bash ../deps.sh
