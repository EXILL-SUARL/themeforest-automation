#!/usr/bin/env bash

set -e

SOURCE="."
TARGET="/tmp/target"
OUTPUT_NAME="package.zip"
OUTPUT_PATH="$TARGET/$OUTPUT_NAME"
PARENT_DIR="package-test"
TO_SEPERATE="dir"

package.sh "$SOURCE" "$TARGET" "$OUTPUT_NAME" "$PARENT_DIR" "$TO_SEPERATE"

if [ ! -e "$OUTPUT_PATH" ]; then
  printf '%s\n' "Output existence test for package.sh has failed." >&2
  exit 1;
fi

TMP_DIR=$(mktemp -d)
unzip "$OUTPUT_PATH" -d "$TMP_DIR"

# Compare the extracted directory with the content directory
diff -r "$TARGET/content" "$TMP_DIR" || DIFF_EXIT_CODE=$?

# Check if the diff command produced any output
if [[ $DIFF_EXIT_CODE -ne 0 ]]; then
  printf '%s\n' "Directory comparison test has failed. The extracted directory is not identical to the content." >&2
  exit 1;
fi

# Check if the content exists and contains a folder named the $PARENT_DIR
if [ ! -d "$TARGET/content/$PARENT_DIR" ]; then
  printf '%s\n' "Directory existence test for "$TARGET/content/$PARENT_DIR" has failed." >&2
  exit 1;
fi

# Check if $PARENT_DIR does not contain a file or folder named $TO_SEPERATE
if [ -e "$TARGET/content/$PARENT_DIR/$TO_SEPERATE" ] || [ -d "$TARGET/content/$PARENT_DIR/$TO_SEPERATE" ]; then
  printf '%s\n' "File or directory existence test for "$TARGET/content/$PARENT_DIR/$TO_SEPERATE" has failed." >&2
  exit 1;
fi

# Check if the content does contain a file or folder named $TO_SEPERATE
if [ ! -e "$TARGET/content/$TO_SEPERATE" ] || [ ! -d "$TARGET/content/$TO_SEPERATE" ]; then
  printf '%s\n' "File or directory inexistence test for "$TARGET/content/$PARENT_DIR/$TO_SEPERATE" has failed." >&2
  exit 1;
fi
