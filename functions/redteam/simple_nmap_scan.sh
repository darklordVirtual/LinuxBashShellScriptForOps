#!/usr/bin/env bash
# Quick nmap scan of a host to list open ports

set -euo pipefail

usage() {
    echo "Usage: $0 <host> [ports]"
    echo "Performs a simple nmap scan against the given host."
    echo "If ports are provided, they are passed to nmap's -p option." 
}

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

HOST="$1"
PORTS="${2-}"

if ! command -v nmap >/dev/null 2>&1; then
    echo "nmap not found; please install nmap" >&2
    exit 1
fi

if [[ -n "$PORTS" ]]; then
    nmap -Pn -p "$PORTS" "$HOST"
else
    nmap -Pn -F "$HOST"
fi
