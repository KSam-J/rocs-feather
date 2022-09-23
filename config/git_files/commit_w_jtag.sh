#!/bin/bash

ONE_LINER="${1}"

J_TAG_REGEX='^[A-Z]{1,4}-\d{1,4}'

# Get the Jira Tag from the branch name
J_TAG=$(git branch --show-current | grep --perl-regexp --only-matching "${J_TAG_REGEX}")
# Check that J_TAG is populated
if [[ -z ${J_TAG} ]]; then
    J_TAG=NOTRACKER
fi

MESSAGE=''
EDIT=0  # True
# Process one_liner if provided
if [[ -n ${ONE_LINER} ]]; then
    MESSAGE="[${J_TAG}] ${ONE_LINER}"

    # Don't edit if within char limit
    if [[ ${#MESSAGE} -le 50 ]]; then
        EDIT=1  # False
        echo "EDIT = ${EDIT}"
    fi

else
    MESSAGE="[${J_TAG}] "
fi

# Execute git commit
if [[ ${EDIT} -eq 0 || ${J_TAG} == 'NOTRACKER' ]]; then
    git commit --message="${MESSAGE}" --edit
else
    git commit --message="${MESSAGE}"
fi

