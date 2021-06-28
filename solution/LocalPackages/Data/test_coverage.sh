#!/bin/sh

BIN_PATH="$(swift build --show-bin-path)"
XCTEST_PATH="$(find ${BIN_PATH} -name '*.xctest')"

COVERAGE_BIN=$XCTEST_PATH
if [[ "$OSTYPE" == "darwin"* ]]; then
    file="$(basename $XCTEST_PATH .xctest)"
    COVERAGE_BIN="${COVERAGE_BIN}/Contents/MacOS/$file"
fi

llvm-cov report \
    "${COVERAGE_BIN}" \
    -instr-profile=.build/debug/codecov/default.profdata \
    -ignore-filename-regex=".build|Tests" \
    -use-color