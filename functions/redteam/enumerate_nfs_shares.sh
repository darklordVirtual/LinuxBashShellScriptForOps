#!/usr/bin/env bash
# Enumerate NFS exports from a host
set -euo pipefail

usage() {
    echo "Usage: $0 <host>"
}

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

HOST="$1"

if ! command -v showmount >/dev/null 2>&1; then
    echo "showmount command is required" >&2
    exit 1
fi

showmount -e "$HOST" || {
    echo "Failed to enumerate NFS shares" >&2
    exit 1
}
