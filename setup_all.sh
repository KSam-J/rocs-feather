#!/bin/bash

# Set all symlinks
cd config # scripts expect to be run in their dir
. ./set_sym_links.sh
cd ..

# Install apt packages
. linux_tools.sh

# Make bash tab completes case-insensitive
. config/bash_files/case-insensitive.sh
