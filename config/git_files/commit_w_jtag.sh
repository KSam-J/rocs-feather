#!/bin/bash

ONE_LINER="${1}"

J_TAG_REGEX='^[A-Z]{1,4}-\d{1,4}'

# Get the Jira Tag from the branch name
J_TAG=$(git branch --show-current | grep --perl-regexp --only-matching "${J_TAG_REGEX}")

# Check that J_TAG is populated
if [[ -n ${J_TAG} ]]; then
    if [[ -n ${ONE_LINER} ]]; then
        git commit --message="[${J_TAG}] ${ONE_LINER}"
    else
        git commit --message="[${J_TAG}] " --edit
    fi
else
    if [[ -n ${ONE_LINER} ]]; then
        git commit --message="[NOTRACKER] ${ONE_LINER}" --edit
    else
        git commit --message="[NOTRACKER] " --edit
    fi
fi

