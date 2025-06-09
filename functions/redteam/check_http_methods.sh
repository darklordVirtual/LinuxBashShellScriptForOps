#!/usr/bin/env bash
# Check supported HTTP methods on a target URL
set -euo pipefail

usage() {
    echo "Usage: $0 <url>"
    echo "Queries allowed HTTP methods with an OPTIONS request."
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

curl -X OPTIONS -is "$URL" | grep -i Allow || {
    echo "Unable to retrieve allowed methods" >&2
    exit 1
}
