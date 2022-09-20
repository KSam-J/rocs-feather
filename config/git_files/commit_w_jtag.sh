#!/bin/bash

ONE_LINER="${1}"

J_TAG_REGEX='^[A-Z]{1,4}-\d{1,4}'

# Get the Jira Tag from the branch name
# function
J_TAG=$(git branch --show-current | grep --perl-regexp --only-matching "${J_TAG_REGEX}")

# Check that J_TAG is populated
if [[ -z ${J_TAG} ]]; then
    J_TAG='NOTRACKER'
fi
# potential function end

# Take J_TAG and attempt to attach ONE_LINER
if [[ -n ${ONE_LINER} ]]; then
    git commit --message="[${J_TAG}] ${ONE_LINER}"
else
    git commit --message="[${J_TAG}] " --edit
fi

