#!/usr/bin/env bash
# Collect basic system information for recon
set -euo pipefail

hostname
uname -a
id
netstat -tulpn 2>/dev/null || true
