#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -z "${PREFIX:-}" ]]; then
    echo "TUKU installer: PREFIX is not set."
    echo "Run this installer inside Termux."
    exit 1
fi

if [[ ! -d "$PREFIX" || ! -w "$PREFIX" ]]; then
    echo "PREFIX is not writable: $PREFIX"
    exit 1
fi

BIN_DIR="$PREFIX/bin"
LIB_DIR="$PREFIX/lib/tuku"

mkdir -p "$BIN_DIR"
mkdir -p "$LIB_DIR/.compiler/Packages"
mkdir -p "$LIB_DIR/.TUKU/EDITOR"

install -m 755 "$REPO_ROOT/tuku" "$BIN_DIR/tuku"

for file in Compile.sh Compiler-c.sh Compiler-c++.sh Compile-c#.sh
do
    install -m 755 \
        "$REPO_ROOT/.compiler/$file" \
        "$LIB_DIR/.compiler/$file"
done

install -m 755 \
    "$REPO_ROOT/.compiler/Packages/FetchPackages.sh" \
    "$LIB_DIR/.compiler/Packages/FetchPackages.sh"

install -m 644 \
    "$REPO_ROOT/.TUKU/EDITOR/editor.properties" \
    "$LIB_DIR/.TUKU/EDITOR/editor.properties"

install -m 644 \
    "$REPO_ROOT/.TUKU/EDITOR/editor.syntax.properties" \
    "$LIB_DIR/.TUKU/EDITOR/editor.syntax.properties"

echo "TUKU installed successfully."
echo "Run: tuku"
