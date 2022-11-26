#!/usr/bin/env bash

set -e

SOURCE=.
TARGET=$SOURCE/output
OUTPUT_NAME=compressed
OUTPUT_PATH=$TARGET/$OUTPUT_NAME.zip

dir-zip.sh $SOURCE $TARGET $OUTPUT_NAME

if [ ! -e $OUTPUT_PATH ]; then
  printf '%s\n' "Output existence test for dir-zip.sh has failed." >&2
  exit 1;
fi
