#!/usr/bin/env bash

# Zips a directory.

set -e

function usage {
  echo "usage: $0 <source_directory> <target_path> <output_filename> <parent_directory_name> <items_to_seperate>"
}

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" || -z "$5" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

CONTENT_DIR="content"

if [ ! -d "$2" ]; then
  mkdir -p "$2/$CONTENT_DIR"
fi

rsync -avh --exclude="$5" "$1" "$2/$CONTENT_DIR/$4"

rsync -avh "$5" "$2/$CONTENT_DIR"

TEMP_PWD=$PWD

cd "$2/$CONTENT_DIR" && zip -r "$2/$3" . && cd $TEMP_PWD
