#!/usr/bin/env bash
# Summarize failed SSH login attempts from auth.log

set -euo pipefail

LOGFILE="/var/log/auth.log"

usage() {
    echo "Usage: $0 [logfile]"
    echo "Counts failed SSH login attempts by IP address from the specified log file."
}

if [[ ${1-} ]]; then
    LOGFILE="$1"
fi

if [[ ! -f "$LOGFILE" ]]; then
    echo "log file $LOGFILE does not exist" >&2
    exit 1
fi

echo "Failed login attempts by IP in $LOGFILE:" 

grep 'Failed password' "$LOGFILE" | awk '{for(i=1;i<=NF;i++) if ($i=="from") {print $(i+1)}}' | sort | uniq -c | sort -nr
