#!/usr/bin/env bash
# Check if RDP port is open
set -euo pipefail

usage() {
    echo "Usage: $0 <host>"
}

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

HOST="$1"

if ! command -v nc >/dev/null 2>&1; then
    echo "nc (netcat) is required" >&2
    exit 1
fi

nc -z -w3 "$HOST" 3389 && echo "RDP port open" || {
    echo "RDP port closed" >&2
    exit 1
}
