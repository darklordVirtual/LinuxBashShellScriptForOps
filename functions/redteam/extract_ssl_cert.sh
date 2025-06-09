#!/usr/bin/env bash
# Retrieve and display SSL certificate details
set -euo pipefail

usage() {
    echo "Usage: $0 <host> [port]"
}

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

HOST="$1"
PORT="${2-443}"

if ! command -v openssl >/dev/null 2>&1; then
    echo "openssl not found" >&2
    exit 1
fi

openssl s_client -connect "$HOST:$PORT" -showcerts </dev/null 2>/dev/null | openssl x509 -noout -text || {
    echo "Failed to retrieve certificate" >&2
    exit 1
}
