#!/usr/bin/env bash
# nvim-theme.sh — Change the colorscheme in all running nvim instances and update
#                 the manifest so future instances start with the correct theme.
# Usage: nvim-theme.sh <colorscheme-name>
# Example: nvim-theme.sh starfield-light

set -euo pipefail

COLORSCHEME="${1:?Usage: nvim-theme.sh <colorscheme-name>}"
SOCKET_DIR="$HOME/.local/state/nvim/sockets"
MANIFEST="$HOME/.config/theme-current"

# Update manifest
if [[ -f "$MANIFEST" ]]; then
    if grep -q '^NVIM_THEME=' "$MANIFEST"; then
        sed -i "s|^NVIM_THEME=.*|NVIM_THEME=${COLORSCHEME}|" "$MANIFEST"
    else
        echo "NVIM_THEME=${COLORSCHEME}" >> "$MANIFEST"
    fi
fi

if [[ ! -d "$SOCKET_DIR" ]]; then
    echo "nvim-theme: set to ${COLORSCHEME} (no socket dir; will apply on next nvim start)"
    exit 0
fi

notified=0
stale=0

for sock in "$SOCKET_DIR"/*.sock; do
    [[ -S "$sock" ]] || continue  # skip if not a real socket (glob miss)

    # Liveness check: extract PID from filename (nvim-<pid>.sock) and test process.
    # This avoids spawning nvim against a dead socket, which causes a core dump.
    sock_pid=$(basename "$sock" .sock)
    sock_pid="${sock_pid#nvim-}"
    if ! kill -0 "$sock_pid" 2>/dev/null; then
        rm -f "$sock"
        (( stale++ )) || true
        continue
    fi

    nvim --server "$sock" --remote-send ":colorscheme ${COLORSCHEME}<CR>" 2>/dev/null || true
    (( notified++ )) || true
done

echo "nvim-theme: set to ${COLORSCHEME} (notified ${notified} instance(s), cleaned ${stale} stale socket(s))"
