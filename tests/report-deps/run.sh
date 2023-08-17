#!/usr/bin/env bash

set -e

DECISIONS_FILE=./doc/dependency_decisions.yml
OUTPUT_DIR=./output
OUTPUT_FILE=$OUTPUT_DIR/license_report.html

report-deps.sh "$DECISIONS_FILE" "$OUTPUT_DIR"

STRIP() {
  echo "$(cat - | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')"
}

STRINGS_TO_CHECK=('10 total' '9 MIT' '1 BSD Zero Clause License' 'MIT manually approved ✓ 2022-11-02 axios v1.1.3 (dependencies)' 'MIT manually approved ✓ 2022-11-02 chalk v5.1.2 (dependencies)' 'MIT manually approved ✓ 2022-11-02 commander v9.4.1 (dependencies)' 'MIT manually approved ✓ 2022-11-02 express v4.18.2 (dependencies)' 'MIT manually approved ✓ 2022-11-02 lodash v4.17.21 (dependencies)' 'MIT manually approved ✓ 2022-11-02 moment v2.29.4 (dependencies)' 'MIT manually approved ✓ 2022-11-02 react v18.2.0 (dependencies)' 'MIT manually approved ✓ 2022-11-02 react-dom v18.2.0 (dependencies)' 'BSD Zero Clause License manually approved ✓ 2022-11-02 tslib v2.4.1 (dependencies)' 'MIT manually approved ✓ 2022-11-02 vue v3.2.41 (dependencies)')

PANDOC_STDOUT="$(pandoc --from html --to plain "$OUTPUT_FILE")"

for STRING in "${STRINGS_TO_CHECK[@]}"; do
  if ! grep -q "$(echo $STRING | STRIP)" <<< "$(echo $PANDOC_STDOUT | STRIP)" ; then
    printf '%s\n' "Test for report-deps.sh has failed. /n Could not find string: $STRING." >&2
    exit 1;
  fi
done
