#!/usr/bin/env bash
# Capture WiFi probe requests using tcpdump
set -euo pipefail

usage() {
    echo "Usage: $0 <interface>"
}

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

IFACE="$1"

if ! command -v tcpdump >/dev/null 2>&1; then
    echo "tcpdump is required" >&2
    exit 1
fi

tcpdump -I -i "$IFACE" type mgt subtype probe-req -vv
