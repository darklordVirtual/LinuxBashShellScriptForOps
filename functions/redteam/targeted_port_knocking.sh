#!/usr/bin/env bash
# Send a custom port knocking sequence
set -euo pipefail

usage() {
    echo "Usage: $0 <host> <port1,port2,...>"
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

HOST="$1"
PORTS="$2"

IFS=',' read -ra arr <<< "$PORTS"
for p in "${arr[@]}"; do
    nc -z -w1 "$HOST" "$p" || true
    sleep 1
done
