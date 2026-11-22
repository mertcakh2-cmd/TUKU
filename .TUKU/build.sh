#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -z "${PREFIX:-}" ]]; then
    echo "TUKU requires Termux."
    exit 1
fi

BIN="$PREFIX/bin"
LIB="$PREFIX/lib/tuku"

mkdir -p "$BIN" "$LIB/.compiler/Packages"

cp "$REPO_ROOT/.compiler/Compile.sh" "$LIB/.compiler/"
cp "$REPO_ROOT/.compiler/Compiler-c.sh" "$LIB/.compiler/"
cp "$REPO_ROOT/.compiler/Compiler-c++.sh" "$LIB/.compiler/"
cp "$REPO_ROOT/.compiler/Compile-c#.sh" "$LIB/.compiler/"
cp "$REPO_ROOT/.compiler/Packages/FetchPackages.sh" "$LIB/.compiler/Packages/"

chmod +x "$LIB/.compiler/"*.sh
chmod +x "$LIB/.compiler/Packages/"*.sh

cat > "$BIN/tuku" <<EOF
#!/usr/bin/env bash
set -euo pipefail

ROOT="$LIB"

case "\${1:-help}" in
    version|--version)
        echo "TUKU 0.1.0"
        ;;
    compile|build)
        [[ \$# -ge 2 ]] || {
            echo "Usage: tuku compile <source-file>"
            exit 2
        }
        exec bash "\$ROOT/.compiler/Compile.sh" "\$2"
        ;;
    packages)
        exec bash "\$ROOT/.compiler/Packages/FetchPackages.sh"
        ;;
    *)
        echo "TUKU - Termux Coding Toolkit"
        echo "Usage:"
        echo "  tuku version"
        echo "  tuku compile <file>"
        echo "  tuku packages"
        ;;
esac
EOF

chmod +x "$BIN/tuku"

echo "TUKU installed successfully!"
echo "Run: tuku"
