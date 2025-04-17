#!/usr/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /tmp/rust_installer.sh

sudo chmod +x /tmp/rust_installer
/tmp/rust_installer.sh --no-modify-path

