#!/usr/bin/env bash
set -euo pipefail

if ! command -v pkg >/dev/null 2>&1; then
    echo "This package helper is intended for Termux."
    echo "The pkg command was not found."
    exit 1
fi

echo "Updating Termux package lists..."

pkg update

echo "Installing TUKU build tools..."

pkg install -y \
    bash \
    coreutils \
    findutils \
    git \
    clang \
    make

echo
echo "TUKU packages are ready."

echo "C compiler: $(command -v clang || true)"
echo "C++ compiler: $(command -v clang++ || true)"
