#!/usr/bin/env bash
# install-udev.sh — Set up everything needed for the floppy-trigger system:
#   1. Creates the nvim socket directory
#   2. Creates the tmux current.tmuxtheme symlink
#   3. Initializes ~/.config/theme-current manifest
#   4. Installs the udev rule for USB theme switching (requires sudo)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROCS_CONFIG="$(cd "$SCRIPT_DIR/../config" && pwd)"

echo "=== floppy-trigger install ==="

# 1. Nvim socket directory
SOCKET_DIR="$HOME/.local/state/nvim/sockets"
mkdir -p "$SOCKET_DIR"
echo "✓ nvim socket dir: $SOCKET_DIR"

# 2. tmux current.tmuxtheme symlink
# ~/.config/tmux/ is a symlink to the repo dir (set by set_sym_links.sh).
# current.tmuxtheme is a relative symlink inside that dir, already tracked in git.
# Nothing extra to do here — the repo ships with current.tmuxtheme -> starfield-light.tmuxtheme.
echo "✓ tmux current.tmuxtheme is managed as a relative symlink in rocs-feather/config/tmux/"

# 3. Initialize theme manifest
MANIFEST="$HOME/.config/theme-current"
if [[ ! -f "$MANIFEST" ]]; then
    cat > "$MANIFEST" <<'EOF'
NVIM_THEME=starfield-light
TMUX_THEME=starfield-light
ALACRITTY_THEME=grey.toml
EOF
    echo "✓ created manifest: $MANIFEST"
else
    echo "  manifest already exists: $MANIFEST (skipped)"
fi

# 4. Make all scripts executable
chmod +x "$SCRIPT_DIR"/*.sh
echo "✓ scripts marked executable"

# 5. Install udev rule (requires sudo)
UDEV_RULE="$SCRIPT_DIR/99-theme-usb.rules"
UDEV_DEST="/etc/udev/rules.d/99-theme-usb.rules"

echo ""
echo "Installing udev rule (requires sudo)..."
sudo cp "$UDEV_RULE" "$UDEV_DEST"
sudo udevadm control --reload-rules
echo "✓ udev rule installed: $UDEV_DEST"

echo ""
echo "=== install complete ==="
echo ""
echo "Next steps:"
echo "  • Ensure ~/.tmux.conf sources ~/.config/tmux/current.tmuxtheme (see rocs-feather config)"
echo "  • Ensure nvim options.lua calls vim.fn.serverstart() (see rocs-feather config)"
echo "  • Test with: $SCRIPT_DIR/mock-floppy.sh starfield-light"
