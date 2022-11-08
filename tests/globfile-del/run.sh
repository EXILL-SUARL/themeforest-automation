#!/usr/bin/env bash

set -e

globfile-del.sh ./.ignore

COUNT=$(find . | wc -l)

if [ $COUNT != 6 ]; then
  printf '%s\n' "Files count test for globfile-del.sh has failed." >&2
  exit 1;
fi
