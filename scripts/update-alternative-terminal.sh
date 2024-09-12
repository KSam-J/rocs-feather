#!/bin/bash
# Set alacritty as the default terminal using update-alternatives
#
# Does not care about CWD
#
# Assumes alacritty has already been installed


ALACRITTY_LOCATION="$(which alacritty)"

if [[ -z $ALACRITTY_LOCATION ]]; then
    echo "Alacritty not installed, alternatives not updated"
    exit 1
fi

# Add alacritty to the alternatives list
# --install <link> <name> <path> <priority>
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator ${ALACRITTY_LOCATION} 1

# Set alacritty to be the default terminal
# --set <name> <path>
sudo update-alternatives --set x-terminal-emulator ${ALACRITTY_LOCATION}
