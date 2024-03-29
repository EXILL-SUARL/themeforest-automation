#!/usr/bin/env bash

# Mass blur all images/videos in the specified directory.

set -e

function usage {
  echo "usage: $0 <target_directory>"
}

if [[ -z "$1" ]]; then
  printf '%s\n' "Target directory is missing." >&2
  usage
  exit 1;
fi

if [ ! -d "$1" ]; then
  printf '%s\n' "Target directory does not exist." >&2
  usage
  exit 1;
fi

find "$1" -iregex '.*\.\(jpg\|gif\|ico\|png\|jpeg\|webp\)$' -type f -exec convert -blur 0x20 {} {} \;

find "$1" -iregex '.*\.\(mp4\|webm\|mov\|m4v\|mkv\)' -type f -exec sh -c '
  filepath="{}"
  appended_string="_blurred.temp.${filepath##*.}"
  output="${filepath%.*}$appended_string"
  ffmpeg -y -i "$filepath" -vf "gblur=sigma=50" -c:a copy "$output"
  mv "$output" "$filepath"
' \;
