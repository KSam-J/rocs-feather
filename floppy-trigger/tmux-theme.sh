#!/usr/bin/env bash
# tmux-theme.sh — Update the active tmux theme across all live sessions.
# Usage: tmux-theme.sh <theme-name>
# Example: tmux-theme.sh flexoki-dark
#
# ~/.config/tmux/ is a symlink to rocs-feather/config/tmux/, so updating
# current.tmuxtheme here also updates the repo's tracked symlink.
#
# Theme files use shell variable syntax for color definitions. tmux source-file
# does not expand shell variables, so we resolve them through bash first and
# pipe the expanded tmux commands into tmux source-file /dev/stdin.

set -euo pipefail

THEME_NAME="${1:?Usage: tmux-theme.sh <theme-name>}"
TMUX_CONFIG_DIR="$HOME/.config/tmux"
THEME_FILE="${TMUX_CONFIG_DIR}/${THEME_NAME}.tmuxtheme"
SYMLINK="${TMUX_CONFIG_DIR}/current.tmuxtheme"
MANIFEST="$HOME/.config/theme-current"

if [[ ! -f "$THEME_FILE" ]]; then
    echo "tmux-theme: theme file not found: ${THEME_FILE}" >&2
    exit 1
fi

# Use a relative target so the symlink is valid whether accessed via the
# real repo path or the ~/.config/tmux symlink.
ln -sf "${THEME_NAME}.tmuxtheme" "$SYMLINK"

# Update manifest
if [[ -f "$MANIFEST" ]]; then
    if grep -q '^TMUX_THEME=' "$MANIFEST"; then
        sed -i "s|^TMUX_THEME=.*|TMUX_THEME=${THEME_NAME}|" "$MANIFEST"
    else
        echo "TMUX_THEME=${THEME_NAME}" >> "$MANIFEST"
    fi
fi

# Apply to tmux: source the file through bash so shell variables are expanded,
# extract only tmux set/setw lines, substitute variables via envsubst, then
# feed into tmux.
if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null 2>&1; then
    # Extract only shell variable assignments into a temp file so that sourcing
    # doesn't try to execute the tmux set/setw lines as bash commands.
    tmp_vars=$(mktemp)
    grep -E '^[a-zA-Z_][a-zA-Z0-9_]*=' "$THEME_FILE" > "$tmp_vars"

    # set -a auto-exports every variable defined while sourcing, making them
    # available to envsubst downstream.
    set -a
    # shellcheck source=/dev/null
    source "$tmp_vars"
    set +a
    rm -f "$tmp_vars"

    grep -E '^\s*(set|setw)\b' "$THEME_FILE" \
        | envsubst \
        | tmux source-file /dev/stdin || true

    tmux refresh-client -S
    echo "tmux-theme: set to ${THEME_NAME} (reloaded all sessions)"
else
    echo "tmux-theme: set to ${THEME_NAME} (no running tmux sessions)"
fi
