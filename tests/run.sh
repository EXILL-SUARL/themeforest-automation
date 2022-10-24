#!/usr/bin/env bash

set -e

ORIGINAL_PWD="$PWD"

if [ "$CI" == 'true' ]; then
  TESTS_DIR="/tmp/tests"
else
  TESTS_DIR="$PWD/tests"
fi

for dir in `ls $TESTS_DIR`; do
TEST_DIR=$TESTS_DIR/$dir
if [ -d $TEST_DIR ]; then
  cd $TEST_DIR
  ./run.sh
  cd $ORIGINAL_PWD
fi
done
