#!/usr/bin/env bash

set -e

declare -A ASSETS_SHA1

ASSETS_DIR="."

SHA256_GET_VALUE=""

GET_SHA256() {
  echo "$(cat - | cut -d " " -f 1)"
}

SLUGIFY() {
  echo "$(cat - | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"
}

for FILE in "$(ls "$ASSETS_DIR")"; do
  FILE_PATH="$ASSETS_DIR/$FILE"
  SHA1=$(sha256sum "$FILE_PATH" | GET_SHA256)
  ASSETS_SHA1["$(echo "$FILE" | base64)"]=$SHA1
done

batch-blur.sh "$ASSETS_DIR"

for KEY in "${!ASSETS_SHA1[@]}"; do
  FILE_PATH="$ASSETS_DIR/$(echo "$KEY" | base64 -d)"
  OLD_SHA1=${ASSETS_SHA1[$KEY]}
  SHA1=$(sha256sum "$FILE_PATH" | GET_SHA256)
  if [ "$OLD_SHA1" = "$SHA1" ]; then
    printf '%s\n' "Checksums test for dir-zip.sh has failed." >&2
    exit 1;
  fi
done
