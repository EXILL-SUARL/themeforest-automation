#!/usr/bin/env bash

# Zips a directory.

set -e

function usage {
  echo "usage: $0 <source_directory> <target_path> <output_filename>"
}

if [[ -z "${1}" || -z "${2}" || -z "${3}" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

if [ ! -d $2 ]; then
  mkdir -p $2
fi

zip -r $2/$3 $1
