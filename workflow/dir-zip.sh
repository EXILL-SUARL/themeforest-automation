#!/usr/bin/env bash

# Zips a directory.

if [[ -z "${1}" || -z "${2}" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  exit 1;
fi

zip -r $2.zip $1
