#!/bin/bash
# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
# Copyright 2021 Variscite Ltd.
# Copyright (additional changes) 2023 Benchmark

# verify container user was set in dockerfile
if [ -z "${USER}" ]; then
  echo "Set user in Dockerfile";
  exit -1
fi

# verify host uid and gid passed in
if [ -z "${HOST_USER_ID}" -a -z "${HOST_USER_GID}" ]; then
    echo "Pass host uid and gid in docker run command" ;
    echo "e.g. -e HOST_USER_ID=$uid -e HOST_USER_GID=$gid" ;
    exit -2
fi

# replace uid and guid in /etc/passwd and /etc/group
sed -i -e "s/^${USER}:\([^:]*\):[0-9]*:[0-9]*/${USER}:\1:${HOST_USER_ID}:${HOST_USER_GID}/"  /etc/passwd
sed -i -e "s/^${USER}:\([^:]*\):[0-9]*/${USER}:\1:${HOST_USER_GID}/"  /etc/group

# allow user to run sudo
adduser ${USER} sudo

#change to working directory after login
echo "cd /rocs_feather" > /home/${USER}/.bashrc

# If ENV_RUN_SCRIPT set in Docker Environment, run it after login
if [ ! "${ENV_RUN_SCRIPT}" = "" ]; then
    echo "${ENV_RUN_SCRIPT}" >> /home/${USER}/.bashrc
fi

# If no arguments provided, just go into bash shell. Also, keep the user's SSH
# socket available in the container, if defined.
if [ $# -eq 0 ]
then
    sudo \
        -u "${USER}" \
        --preserve-env=SSH_AUTH_SOCK \
	bash
else
    sudo \
        -u "${USER}" \
        --preserve-env=SSH_AUTH_SOCK \
        "$@"
fi
