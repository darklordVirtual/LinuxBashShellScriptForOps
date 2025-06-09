#!/usr/bin/env bash
# Find potential SUID binaries for privilege escalation
set -euo pipefail

find / -perm -4000 -type f 2>/dev/null | sort
