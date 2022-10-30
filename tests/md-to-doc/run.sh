#!/usr/bin/env bash

set -e

INPUT_TEMPLATE=./assets/template.md
INPUT_DATA=./assets/data.json
OUTPUT_DIR=./assets/output
OUTPUT_FILE=$OUTPUT_DIR/template.html

md-to-doc.sh "$(cat $INPUT_DATA)" $INPUT_TEMPLATE $OUTPUT_DIR

STRINGS_TO_CHECK=('<h1>Demo</h1>' '<p><a href="http://example.org/alice">Alice likes red green yellow </a></p>' '<p><a href="http://example.org/bob">Bob likes orange </a></p>')

for STRING in ${STRINGS_TO_CHECK[@]}; do
  if ! grep -q $STRING "$OUTPUT_FILE" ; then
    printf '%s\n' "Test for md-to-doc.sh has failed." >&2
    exit 1;
  fi
done
