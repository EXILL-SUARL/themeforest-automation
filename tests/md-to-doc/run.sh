#!/usr/bin/env bash

set -e

INPUT_TEMPLATE=./template.md
INPUT_DATA=./data.json
OUTPUT_DIR=./output
OUTPUT_FILE=$OUTPUT_DIR/template.html

RUST_BACKTRACE=1 md-to-doc.sh "$(cat "$INPUT_DATA")" "$INPUT_TEMPLATE" "$OUTPUT_DIR"

STRINGS_TO_CHECK=('<h1>Demo</h1>' '<li><a href="http://example.org/alice">Alice likes red green yellow </a></li>' '<li><a href="http://example.org/bob">Bob likes orange </a></li>')

for STRING in "${STRINGS_TO_CHECK[@]}"; do
  if ! grep -q "$STRING" "$OUTPUT_FILE" ; then
    printf '%s\n' "Test for md-to-doc.sh has failed.  /n Could not find string: $STRING." >&2
    exit 1;
  fi
done
