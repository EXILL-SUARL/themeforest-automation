#!/usr/bin/env bash

# Zips a directory.

set -e

function usage {
  echo "usage: $0 <source_directory> <target_path> <output_filename> <parent_directory_name> <items_to_seperate> <seperated_dir_name> <container_dir_name>"
}

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" || -z "$5" || -z "$6" || -z "$7" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

if [ ! -d "$2" ]; then
  mkdir -p "$2/$7"
fi

rsync -avh --exclude="$5" "$1" "$2/$7/$4"

rsync -avh "$5/" "$2/$7/$6"

TEMP_PWD=$PWD

cd "$2/$7" && zip -r "$2/$3" . && cd $TEMP_PWD
