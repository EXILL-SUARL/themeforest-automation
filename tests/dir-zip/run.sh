#!/usr/bin/env bash

set -e

SOURCE=./assets
TARGET=$SOURCE/output
OUTPUT_NAME=compressed
OUTPUT_PATH=$TARGET/$OUTPUT_NAME.zip

dir-zip.sh $SOURCE $TARGET $OUTPUT_NAME
