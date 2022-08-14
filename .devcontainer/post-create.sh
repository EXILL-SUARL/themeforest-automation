#!/usr/bin/env bash

sudo apt update && sudo apt -y upgrade

yarn global add @devcontainers/cli
brew install neovim

# Install Node packages
yarn global add ts-node