#!/usr/bin/env bash

set -e

PARSED_METADATA=$(metadata-parser.sh item-one.json item-two.json item-three.json item-four.json item-two.json)

if ! diff <(cat results.json | jq --sort-keys) <(echo $PARSED_METADATA | jq --sort-keys) ; then
  printf '%s\n' "Test for metadata-parser.sh has failed." >&2
  exit 1;
fi
