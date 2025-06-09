#!/usr/bin/env bash
# Get the public IP address of the current machine
#
# This script tries several online services to determine the
# externally visible IPv4 address. It falls back between curl,
# wget and dig so it works on minimal systems.
#
# Usage:
#   bash get_public_ip.sh
#
# Example:
#   ./get_public_ip.sh
#
# Output:
#   Prints the detected public IP or exits with a non-zero status
#   if none of the services can be reached.
set -euo pipefail

get_ip(){
  local url=$1
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" && return 0
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$url" && return 0
  fi
  return 1
}

services=("https://api.ipify.org" "https://ifconfig.me/ip")
for srv in "${services[@]}"; do
  if ip=$(get_ip "$srv" 2>/dev/null); then
    echo "$ip"
    exit 0
  fi
done

if command -v dig >/dev/null 2>&1; then
  dig +short myip.opendns.com @resolver1.opendns.com
else
  echo "Unable to determine public IP" >&2
  exit 1
fi
