#!/bin/bash
# Set alacritty as the default terminal using update-alternatives

# Check script was run with sudo
if [ "$EUID" -ne 0 ];then
    echo "Please run as root (i.e. sudo)"
    exit 1
fi

ALACRITTY_LOCATION="$(which alacritty)"

if [[ -z $ALACRITTY_LOCATION ]]; then
    echo "Alacritty not installed, alternatives not updated"
    exit 1
fi

# Add alacritty to the alternatives list
# --install <link> <name> <path> <priority>
update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 1

# Set alacritty to be the default terminal
# --set <name> <path>
sudo update-alternatives --set x-terminal-emulator /usr/local/bin/alacritty
