#!/usr/bin/env bash

# Generate a single-page documentation from a markdown template and a content data.

set -e

function usage {
  echo "usage: $0 <input_config> <input_markdown> <output_path>"
}

if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
  printf '%s\n' "Invalid CLI arguments" >&2
  usage
  exit 1;
fi

if [ ! -d "$3" ]; then
  mkdir -p "$3"
fi

echo "$1" | tera --template "$2" -s -o "$2"

mdtodoc "$2" --layout "page" --theme "github" --highlight-style "atom-one-light" -d "$3"
