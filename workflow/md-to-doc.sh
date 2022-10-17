#!/usr/bin/env bash

# Generate a single-page documentation from a markdown file.

set -e

function usage {
  echo "usage: $0 <input_markdown> <output_path>"
}

if [[ -z "${1}" || -z "${2}" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

mkdir $2

mdtodoc $1 --layout "page" --theme "github" --highlight-style "atom-one-light" -d $2
