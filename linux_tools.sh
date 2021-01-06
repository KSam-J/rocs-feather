#!/bin/bash

pInstallAll=true

## Check if user is root
if [[ `id -u` = "0" ]]
then
	echo "This script must NOT be run as root, for root actions, sudo is used internally"
	exit 1
fi

PACKAGES_BASE="gcc \
make \
git"

PACKAGES_HANDY="terminator \
vim \
tree \
silversearcher-ag \
xclip"

PACKAGES_DOCKER="apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common"

if [[ ${pInstallAll} == true ]]; then
    sudo apt-get install ${PACKAGES_BASE} ${PACKAGES_HANDY} ${PACKAGES_DOCKER}
fi