#!/usr/bin/env bash
# Compile a C payload for exploitation
set -euo pipefail

usage() {
    echo "Usage: $0 <source.c> <output>"
    echo "Compiles the given C source with gcc and strips the binary."
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

SRC="$1"
OUT="$2"

if ! command -v gcc >/dev/null 2>&1; then
    echo "gcc is required" >&2
    exit 1
fi

if [[ ! -f "$SRC" ]]; then
    echo "Source file not found: $SRC" >&2
    exit 1
fi

gcc "$SRC" -o "$OUT" -O2 -static && strip "$OUT"
