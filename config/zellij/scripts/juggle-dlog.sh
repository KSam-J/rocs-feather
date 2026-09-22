#!/usr/bin/env bash

set -euo pipefail

readonly PANE_NAME="dlog"
readonly NVIM_EXIT_DELAY="0.5"

# Locate every non-plugin pane named "dlog" across the entire session.
mapfile -t dlog_pane_ids < <(
    zellij action list-panes --json |
        jq -r \
            --arg name "$PANE_NAME" \
            '
            .[]
            | select(.is_plugin == false)
            | select(
                .title == $name
                or .pane_name? == $name
            )
            | "terminal_\(.id)"
            '
)

for pane_id in "${dlog_pane_ids[@]}"; do
    # Return Neovim to Normal mode regardless of its current mode.
    zellij action send-keys \
        --pane-id "$pane_id" \
        "Esc" "Esc"

    # Execute :wq to save the current file and exit Neovim.
    zellij action send-keys \
        --pane-id "$pane_id" \
        ":" "w" "q" "Enter"

    # Give Neovim time to finish writing before closing the pane.
    sleep "$NVIM_EXIT_DELAY"

    zellij action close-pane \
        --pane-id "$pane_id"
done

# Open the replacement in the currently active tab.
# New panes receive focus unless --no-focus is specified.
zellij action new-pane \
    --floating \
    --name "$PANE_NAME" \
    --close-on-exit \
    -- /home/samkel/Automation/daylog/dlog.py
