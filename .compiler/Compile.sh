#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: tuku compile <source-file>"
    exit 2
fi

SOURCE="$1"

if [[ ! -f "$SOURCE" ]]; then
    echo "Compile: file not found: $SOURCE"
    exit 1
fi

EXT="${SOURCE##*.}"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

case "$EXT" in

    c)
        exec bash "$SCRIPT_DIR/Compiler-c.sh" "$SOURCE"
        ;;

    cc|cpp|cxx|C)
        exec bash "$SCRIPT_DIR/Compiler-c++.sh" "$SOURCE"
        ;;

    cs)
        exec bash "$SCRIPT_DIR/Compile-c#.sh" "$SOURCE"
        ;;

    *)
        echo "Unsupported extension: .$EXT"
        echo "Supported: .c, .cc, .cpp, .cxx, .cs"
        exit 2
        ;;

esac
