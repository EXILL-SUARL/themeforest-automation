#!/usr/bin/env bash

# Mass blur all images in the specified directory.

function usage {
  echo "usage: $0 <target_directory>"
}

if [[ -z "${1}" ]]; then
  printf '%s\n' "Target directory is missing." >&2
  usage
  exit 1;
fi

find $1 -iregex '.*\.\(jpg\|gif\|ico\|png\|jpeg\|webp\)$' -type f -exec convert -blur 0x20 {} {} \;
