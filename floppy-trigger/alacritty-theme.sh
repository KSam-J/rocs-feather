#!/usr/bin/env bash
# alacritty-theme.sh — Update the active alacritty theme.
# Usage: alacritty-theme.sh <theme-file>
# Example: alacritty-theme.sh flexoki-dark.toml
#
# Alacritty hot-reloads on file change, so just updating the import line is enough.

set -euo pipefail

THEME_FILE="${1:?Usage: alacritty-theme.sh <theme-file>}"
ALACRITTY_TOML="$HOME/.config/alacritty/alacritty.toml"
MANIFEST="$HOME/.config/theme-current"

if [[ ! -f "$ALACRITTY_TOML" ]]; then
    echo "alacritty-theme: $ALACRITTY_TOML not found" >&2
    exit 1
fi

# Replace the active import line; handles single or double quotes and any path.
sed -i "s|^import = \[.*\]|import = [\"~/.config/alacritty/${THEME_FILE}\"]|" "$ALACRITTY_TOML"

# Update manifest
if [[ -f "$MANIFEST" ]]; then
    if grep -q '^ALACRITTY_THEME=' "$MANIFEST"; then
        sed -i "s|^ALACRITTY_THEME=.*|ALACRITTY_THEME=${THEME_FILE}|" "$MANIFEST"
    else
        echo "ALACRITTY_THEME=${THEME_FILE}" >> "$MANIFEST"
    fi
fi

echo "alacritty-theme: set to ${THEME_FILE}"
