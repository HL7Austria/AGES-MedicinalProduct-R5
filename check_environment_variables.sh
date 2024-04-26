#!/bin/bash

log () {
  echo " "
  echo "##############################"
  echo "ERROR: Environment variable $1 does not have a value. $2"
  echo "##############################"
  echo " "
}

exitcode=0

[[ -z "$convertFHIRServer" ]] && { log "convertFHIRServer" "Create a CI/CD variable having that name."; exitcode=1; }
[[ -z "$TERMGIT_CANONICAL" ]] && { log "TERMGIT_CANONICAL" "Create a CI/CD variable having that name."; exitcode=1; }
[[ -z "$TERMGIT_HTML_PROJECT" ]] && { log "TERMGIT_HTML_PROJECT" "Create a CI/CD variable having that name."; exitcode=1; }
[[ -z "$TERMGIT_HTML_PROJECT_DEFAULT_BRANCH" ]] && { log "TERMGIT_HTML_PROJECT_DEFAULT_BRANCH" "Create a CI/CD variable having that name."; exitcode=1; }
[[ -z "$GITLAB_CI_TOKEN" ]] && { log "GITLAB_CI_TOKEN" "Create a CI/CD variable for the user triggering this pipeline: [username]_GITLAB_CI_TOKEN    OR    create a CI/CD variable for a bot-user triggering all subsequent commits: TERMGIT_BOT_CI_TOKEN"; exitcode=1; }
# in case that the TERMGIT_BOT_CI_TOKEN is being used as GITLAB_CI_TOKEN check if TERMGIT_BOT_EMAIL and TERMGIT_BOT_USER_NAME have been set accordingly
[[ $GITLAB_CI_TOKEN == $TERMGIT_BOT_CI_TOKEN && -z "$TERMGIT_BOT_EMAIL" ]] && { log "TERMGIT_BOT_EMAIL" "Create a CI/CD variable having that name."; exitcode=1; }
[[ $GITLAB_CI_TOKEN == $TERMGIT_BOT_CI_TOKEN && -z "$TERMGIT_BOT_USER_NAME" ]] && { log "TERMGIT_BOT_USER_NAME" "Create a CI/CD variable having that name."; exitcode=1; }

# for an integration test (started by GitLab pipeline) the following variables have to be set
if [[ "$CI_PIPELINE_SOURCE" == "pipeline" ]];
then
  if ! [[ -z "$MALAC_CT_PROJECT_BRANCH" ]];
  then
    [[ -z "$CS_INPUT_FORMAT" ]] && { log "CS_INPUT_FORMAT" "For an integration test create a variable having that name."; exitcode=1; }
    [[ -z "$VS_INPUT_FORMAT" ]] && { log "VS_INPUT_FORMAT" "For an integration test create a variable having that name."; exitcode=1; }
    [[ -z "$TERMGIT_TERMINOLOGIES_PROJECT" ]] && { log "TERMGIT_TERMINOLOGIES_PROJECT" "For an integration test create a variable having that name."; exitcode=1; }
    [[ -z "$TERMGIT_TERMINOLOGIES_PROJECT_BRANCH" ]] && { log "TERMGIT_TERMINOLOGIES_PROJECT_BRANCH" "For an integration test create a variable having that name."; exitcode=1; }
  fi
fi

exit $exitcode
