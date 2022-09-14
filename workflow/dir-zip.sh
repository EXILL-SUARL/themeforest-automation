#!/usr/bin/env bash

# Zips a directory.

function usage {
  echo "usage: $0 <source_directory> <target_path>"
}

if [[ -z "${1}" || -z "${2}" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

zip -r $TMPDIR/$2 $1
