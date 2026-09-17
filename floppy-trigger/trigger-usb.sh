#!/usr/bin/env bash
# trigger-usb.sh — Udev entry point for USB theme switching.
# Called by udev with the block device path as the first argument.
# Usage: trigger-usb.sh <device>
# Example: trigger-usb.sh /dev/sdb1
#
# The USB drive's volume label determines the theme. Label the drive with the
# exact theme name (e.g. "starfield-light", "flexoki-dark").

set -euo pipefail

DEVICE="${1:?trigger-usb: no device supplied}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG="$HOME/.local/state/floppy-trigger/usb.log"

mkdir -p "$(dirname "$LOG")"
exec >>"$LOG" 2>&1

echo "[$(date '+%F %T')] trigger-usb: device=${DEVICE}"

# Read the volume label via blkid (no mount needed)
LABEL="$(blkid -s LABEL -o value "$DEVICE" 2>/dev/null || true)"

if [[ -z "$LABEL" ]]; then
    echo "[$(date '+%F %T')] trigger-usb: no label on ${DEVICE}, skipping"
    exit 0
fi

# Normalize label to lowercase for theme lookup
THEME_NAME="${LABEL,,}"
THEME_DEF="${SCRIPT_DIR}/themes/${THEME_NAME}"

if [[ ! -f "$THEME_DEF" ]]; then
    echo "[$(date '+%F %T')] trigger-usb: no theme for label '${LABEL}' (tried '${THEME_NAME}'), skipping"
    exit 0
fi

echo "[$(date '+%F %T')] trigger-usb: applying theme '${THEME_NAME}'"
"$SCRIPT_DIR/change-theme.sh" "$THEME_NAME"
echo "[$(date '+%F %T')] trigger-usb: done"
