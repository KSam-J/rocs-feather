#!/usr/bin/env bash
# trigger-floppy.sh — Udev entry point for floppy-disk theme switching.
# Same logic as trigger-usb.sh but intended for the floppy block device (/dev/fd0).
# Called by udev with the block device path as the first argument.
# Usage: trigger-floppy.sh <device>
# Example: trigger-floppy.sh /dev/fd0
#
# Suggested udev rule (not auto-installed, since hardware may be absent):
#   ACTION=="add", KERNEL=="fd[0-9]", SUBSYSTEM=="block", \
#     RUN+="/home/samkel/Repos/rocs-feather/floppy-trigger/trigger-floppy.sh %E{DEVNAME}"

set -euo pipefail

DEVICE="${1:-/dev/fd0}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG="$HOME/.local/state/floppy-trigger/floppy.log"

mkdir -p "$(dirname "$LOG")"
exec >>"$LOG" 2>&1

echo "[$(date '+%F %T')] trigger-floppy: device=${DEVICE}"

# Read the volume label via blkid (no mount needed)
LABEL="$(blkid -s LABEL -o value "$DEVICE" 2>/dev/null || true)"

if [[ -z "$LABEL" ]]; then
    echo "[$(date '+%F %T')] trigger-floppy: no label on ${DEVICE}, skipping"
    exit 0
fi

THEME_NAME="${LABEL,,}"
THEME_DEF="${SCRIPT_DIR}/themes/${THEME_NAME}"

if [[ ! -f "$THEME_DEF" ]]; then
    echo "[$(date '+%F %T')] trigger-floppy: no theme for label '${LABEL}' (tried '${THEME_NAME}'), skipping"
    exit 0
fi

echo "[$(date '+%F %T')] trigger-floppy: applying theme '${THEME_NAME}'"
"$SCRIPT_DIR/change-theme.sh" "$THEME_NAME"
echo "[$(date '+%F %T')] trigger-floppy: done"
