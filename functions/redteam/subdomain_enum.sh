#!/usr/bin/env bash
# Enumerate subdomains using a wordlist
set -euo pipefail

usage() {
    echo "Usage: $0 <domain> <wordlist>"
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

DOMAIN="$1"
WORDLIST="$2"

if ! command -v dig >/dev/null 2>&1; then
    echo "dig is required" >&2
    exit 1
fi

while read -r sub; do
    dig +short "$sub.$DOMAIN" | grep -v '^$' && echo "$sub.$DOMAIN";
done < "$WORDLIST"
