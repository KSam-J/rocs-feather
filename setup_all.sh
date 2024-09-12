#!/bin/bash

source "./scripts/common.sh"

# Set all symlinks
cd config # scripts expect to be run in their dir
. ./set_sym_links.sh
cd ..

# Install apt packages
. linux_tools.sh

# Make bash tab completes case-insensitive
. config/bash_files/case-insensitive.sh

# Install Rust
if [[ ! $(is_command rustc) ]]; then
    source "./scripts/install_rust.sh"
fi

# Install Rust Tools
if [[ $(is_command cargo) ]]; then
    source "./scripts/install_rust_tools.sh"
fi

