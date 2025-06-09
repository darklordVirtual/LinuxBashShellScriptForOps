#!/usr/bin/env bash
# Enumerate NetBIOS names via nmblookup
set -euo pipefail

usage() {
    echo "Usage: $0 <host>"
}

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

HOST="$1"

if ! command -v nmblookup >/dev/null 2>&1; then
    echo "nmblookup is required" >&2
    exit 1
fi

nmblookup -A "$HOST" || {
    echo "Failed to enumerate NetBIOS" >&2
    exit 1
}
