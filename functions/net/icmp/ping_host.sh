#!/usr/bin/env bash
# Ping a host and print the average latency
#
# A thin wrapper around the `ping` command that extracts
# the average round trip time from its output.
#
# Usage:
#   bash ping_host.sh <host> [count]
#
# Arguments:
#   <host>  Hostname or IP to ping
#   [count] Number of echo requests to send (default: 4)
#
# Example:
#   ./ping_host.sh example.com 5
#
# Output:
#   example.com - average latency: 23.1 ms
set -euo pipefail

host="${1:-}"
count="${2:-4}"

if [[ -z "$host" ]]; then
  echo "Usage: $0 <host> [count]" >&2
  exit 1
fi

ping -c "$count" "$host" | awk -F'/' -v h="$host" '/^rtt/ {printf "%s - average latency: %.1f ms\n", h, $5}'
