#!/bin/bash

# reset variables
export GITLAB_CI_TOKEN=
export GITLAB_USER_OR_TERMGIT_BOT_EMAIL=
export GITLAB_USER_OR_TERMGIT_BOT_NAME=

# concatenate user's login name with '_GITLAB_CI_TOKEN' in order to access environment variable
user_CI_TOKEN=${GITLAB_USER_LOGIN}_GITLAB_CI_TOKEN

# if a user has specified a CI token it will be used
if ! [[ -z "${!user_CI_TOKEN}" ]]; then
  echo "using user based _GITLAB_CI_TOKEN as GITLAB_CI_TOKEN"
  export GITLAB_CI_TOKEN=${!user_CI_TOKEN}
  export GITLAB_USER_OR_TERMGIT_BOT_EMAIL=$GITLAB_USER_EMAIL
  export GITLAB_USER_OR_TERMGIT_BOT_NAME=$GITLAB_USER_NAME
# if for a user no CI token exists the TERMGIT_BOT_CI_TOKEN will be used
elif ! [[ -z "$TERMGIT_BOT_CI_TOKEN" ]]; then
  echo "using BOT-user GITLAB_CI_TOKEN"
  export GITLAB_CI_TOKEN=$TERMGIT_BOT_CI_TOKEN
  export GITLAB_USER_OR_TERMGIT_BOT_EMAIL=$TERMGIT_BOT_EMAIL
  export GITLAB_USER_OR_TERMGIT_BOT_NAME=$TERMGIT_BOT_USER_NAME
fi
