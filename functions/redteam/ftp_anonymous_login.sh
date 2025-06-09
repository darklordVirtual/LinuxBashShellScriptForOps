#!/usr/bin/env bash
# Check if FTP allows anonymous login
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

echo -e "USER anonymous\nPASS test@example.com\nQUIT" | nc "$HOST" 21 | grep -q "230" && {
    echo "Anonymous FTP login allowed";
} || {
    echo "Anonymous FTP login not allowed" >&2;
    exit 1;
}
