#!/usr/bin/env bash

# validate required args
if [[ -z "${1}" || -z "${2}" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  exit 1;
fi

pandoc -t beamer -o $2 $1
