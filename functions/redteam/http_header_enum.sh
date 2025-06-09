#!/usr/bin/env bash
# Enumerate HTTP response headers
set -euo pipefail

usage() {
    echo "Usage: $0 <url>"
}

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

URL="$1"

if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required" >&2
    exit 1
fi

curl -I "$URL" || {
    echo "Failed to fetch headers" >&2
    exit 1
}
