#!/usr/bin/env bash

if [[ -z "${1}" ]]; then
  printf '%s\n' "Target directory is missing." >&2
  exit 1;
fi

find $1 -iregex '.*\.\(jpg\|gif\|ico\|png\|jpeg\|webp\)$' -type f -exec convert -blur 0x20 {} {} \;
