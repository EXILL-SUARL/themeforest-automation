#!/usr/bin/env bash

apt install git build-essential gdb lcov pkg-config libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev lzma lzma-dev tk-dev uuid-dev zlib1g-dev xz-utils -y
PYENV_ROOT=/pyenv
curl https://pyenv.run | PYENV_ROOT=$PYENV_ROOT bash
PYENV_ROOT=$PYENV_ROOT $PYENV_ROOT/bin/pyenv install 3.11.0
