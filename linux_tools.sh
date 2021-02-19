#!/bin/bash

pInstallAll=true

SUDO='sudo'

## Check if user is root
if [[ `id -u` = "0" ]]
then
    SUDO=''
fi

PACKAGES_BASE=(
    gcc         # GNU project C and C++ compiler
    make        # GNU utility to maintain groups of programs
    git         # version control
    smbclient   # ftp-like client to access SMB/CIFS resources
)

PACKAGES_HANDY=(
    terminator
    vim
    tree
    silversearcher-ag
    xclip
    libdigest-sha3-perl
    apt-file            # search for files within Debian packages
    lm-sensors          # print sensors information (like cpu temp)
    texinfo             # Documentation system for on-line information and printed output
    dos2unix            # DOS/Mac to Unix and vice versa text file format converter
)

PACKAGES_DOCKER=(
    apt-transport-https
    ca-certificates
    curl
    gnupg-agent
    software-properties-common
)

PACKAGES_NETHACK=(
    lib64ncurses-dev    # developer's libraries for ncurses (64-bit)
    libxt-dev           # X11 toolkit intrinsics library (development headers)
    libxaw7-dev         # X11 Athena Widget library (development headers)
    bison               # YACC-compatible parser generator
    flex                # fast lexical analyzer generator
)
set -x
if [[ ${pInstallAll} == true ]]; then
    ${SUDO} apt-get update
    ${SUDO} apt-get install -y ${PACKAGES_BASE[@]} ${PACKAGES_HANDY} ${PACKAGES_DOCKER}
    ${SUDO} rm -rf /var/lib/apt/lists/*
fi
set +x
