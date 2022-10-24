#!/usr/bin/env bash

set -e

TESTS_DIR="./tests"
ORIGINAL_PWD="$PWD"

for dir in `ls $TESTS_DIR`; do
TEST_DIR=$PWD/$TESTS_DIR/$dir
if [  -d $TEST_DIR ]; then
  cd $TEST_DIR
  ./run.sh
  cd $ORIGINAL_PWD
fi
done
