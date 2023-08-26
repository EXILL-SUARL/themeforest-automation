#!/usr/bin/env bash

set -e

SOURCE="."
TARGET="/tmp/target"
OUTPUT_NAME="package.zip"
OUTPUT_PATH="$TARGET/$OUTPUT_NAME"
PARENT_DIR="package-test"
TO_SEPERATE="dir"
SEPERATED_DIR_NAME="renamed_dir"
CONTAINER_DIR="content"

package.sh "$SOURCE" "$TARGET" "$OUTPUT_NAME" "$PARENT_DIR" "$TO_SEPERATE" "$SEPERATED_DIR_NAME" "$CONTAINER_DIR"

if [ ! -e "$OUTPUT_PATH" ]; then
  printf '%s\n' "Output existence test for package.sh has failed." >&2
  exit 1;
fi

TMP_DIR=$(mktemp -d)
unzip "$OUTPUT_PATH" -d "$TMP_DIR"

# Compare the extracted parent directory with the container parent directory
diff -r "$TARGET/$CONTAINER_DIR/$PARENT_DIR" "$TMP_DIR/$PARENT_DIR" || PARENT_DIR_DIFF_EXIT_CODE=$?

# Check if the diff command produced any output
if [[ $PARENT_DIR_DIFF_EXIT_CODE -ne 0 ]]; then
  printf '%s\n' "Parent directory comparison test has failed. The extracted directory is not identical to the container." >&2
  exit 1;
fi

# Compare the extracted seperate directory with the container seperate directory
diff -r "$TARGET/$CONTAINER_DIR/$SEPERATED_DIR_NAME" "$TMP_DIR/$SEPERATED_DIR_NAME" || SEPERATE_DIR_DIFF_EXIT_CODE=$?

# Check if the diff command produced any output
if [[ $SEPERATE_DIR_DIFF_EXIT_CODE -ne 0 ]]; then
  printf '%s\n' "Seperate directory comparison test has failed. The extracted directory is not identical to the container." >&2
  exit 1;
fi

# Check if the container exists and contains a folder named the $PARENT_DIR
if [ ! -d "$TARGET/$CONTAINER_DIR/$PARENT_DIR" ]; then
  printf '%s\n' "Directory existence test for "$TARGET/$CONTAINER_DIR/$PARENT_DIR" has failed." >&2
  exit 1;
fi

# Check if the container does contain a file or folder named $TO_SEPERATE
if [ ! -e "$TARGET/$CONTAINER_DIR/$SEPERATED_DIR_NAME" ] || [ ! -d "$TARGET/$CONTAINER_DIR/$SEPERATED_DIR_NAME" ]; then
  printf '%s\n' "File or directory inexistence test for "$TARGET/$CONTAINER_DIR/$SEPERATED_DIR_NAME" has failed." >&2
  exit 1;
fi
