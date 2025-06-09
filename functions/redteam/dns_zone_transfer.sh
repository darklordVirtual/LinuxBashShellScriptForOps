#!/usr/bin/env bash
# Attempt a DNS zone transfer
set -euo pipefail

usage() {
    echo "Usage: $0 <domain> <dns-server>"
    echo "Tries AXFR on the target name server."
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

DOMAIN="$1"
SERVER="$2"

if ! command -v dig >/dev/null 2>&1; then
    echo "dig is required" >&2
    exit 1
fi

dig AXFR "$DOMAIN" @"$SERVER" || {
    echo "Zone transfer failed" >&2
    exit 1
}
