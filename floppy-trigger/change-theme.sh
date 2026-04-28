#!/usr/bin/env bash
# change-theme.sh — Master orchestrator for coordinated theme changes.
# Usage: change-theme.sh <theme-name>
# Example: change-theme.sh starfield-light
#
# Theme names map to files in the themes/ directory alongside this script.
# Each theme file exports: NVIM_THEME, TMUX_THEME, ALACRITTY_THEME

set -euo pipefail

THEME_NAME="${1:?Usage: change-theme.sh <theme-name>}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DEF="${SCRIPT_DIR}/themes/${THEME_NAME}"
MANIFEST="$HOME/.config/theme-current"

if [[ ! -f "$THEME_DEF" ]]; then
    echo "change-theme: unknown theme '${THEME_NAME}'" >&2
    echo "  Available themes: $(ls "$SCRIPT_DIR/themes/" | tr '\n' ' ')" >&2
    exit 1
fi

# Load theme variables
# shellcheck source=/dev/null
source "$THEME_DEF"

# Initialize manifest if absent
if [[ ! -f "$MANIFEST" ]]; then
    touch "$MANIFEST"
fi

echo "change-theme: applying theme '${THEME_NAME}'"

"$SCRIPT_DIR/nvim-theme.sh"       "$NVIM_THEME"
"$SCRIPT_DIR/tmux-theme.sh"       "$TMUX_THEME"
"$SCRIPT_DIR/alacritty-theme.sh"  "$ALACRITTY_THEME"

echo "change-theme: done"
