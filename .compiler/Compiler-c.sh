#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: Compiler-c.sh <source.c>"
    exit 2
fi

SOURCE="$1"

if [[ ! -f "$SOURCE" ]]; then
    echo "File not found: $SOURCE"
    exit 1
fi

if command -v clang >/dev/null 2>&1; then
    COMPILER=clang
elif command -v gcc >/dev/null 2>&1; then
    COMPILER=gcc
else
    echo "Install a C compiler:"
    echo "pkg install clang"
    exit 127
fi

OUTPUT="${SOURCE%.*}"

if [[ "$OUTPUT" == "$SOURCE" ]]; then
    OUTPUT="$SOURCE.out"
fi

echo "TUKU: $COMPILER -> $SOURCE"

"$COMPILER" \
    -std=c11 \
    -Wall \
    -Wextra \
    -O2 \
    "$SOURCE" \
    -o "$OUTPUT"

echo "Built: $OUTPUT"
