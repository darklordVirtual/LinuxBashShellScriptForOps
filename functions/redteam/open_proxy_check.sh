#!/usr/bin/env bash
# Test if a host is an open HTTP proxy
set -euo pipefail

usage() {
    echo "Usage: $0 <host> <port>"
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

HOST="$1"
PORT="$2"

if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required" >&2
    exit 1
fi

curl -x "http://$HOST:$PORT" http://example.com -m 5 >/dev/null && {
    echo "Open proxy detected";
} || {
    echo "Proxy closed or unreachable" >&2;
    exit 1;
}
