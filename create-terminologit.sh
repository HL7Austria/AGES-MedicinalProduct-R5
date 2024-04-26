#!/bin/bash

# Write log to stdout
log () {
  echo " "
  echo "##############################"
  echo "$1"
  echo "##############################"
  echo " "
}

log_simple() {
  echo " "
  echo "------> $1"
  echo " "
}

log "START OF create-terminologit.sh"

# create directory where logs from specific commands will be preserved and will be made accessible via artifacts
# these logs have to be read together with the main pipeline log
log_simple "create logging directory"
rm -rvf log_appendix
mkdir -v log_appendix

# create temporary directory for old versions of resources (content will later be copied to IG's output directory)
log_simple "create directory for old versions"
rm -rvf old
mkdir -v old

# retrieve template for IG
log_simple "clone terminologit-template"
# opening up for templates that are not hosted on gitlab.com, like the original under "https://github.com/HL7/ig-template-base"
if ! [[ -z ${IG_PUB_TEMPLATE_URL+x} ]]
then
  if ! [[ -z ${IG_PUB_TEMPLATE_BRANCH+x} ]]
  then
    git clone -b ${IG_PUB_TEMPLATE_BRANCH} ${IG_PUB_TEMPLATE_URL} ./input/terminologit-template || exit 1
  else
    git clone ${IG_PUB_TEMPLATE_URL} ./input/terminologit-template || exit 1
  fi
else
  git clone https://gitlab.com/elga-gmbh/terminologit-template.git ./input/terminologit-template || exit 1
fi

# for integration tests (triggered by another pipeline) no IGVer will be executed
if [[ $CI_PIPELINE_SOURCE != "pipeline" ]]
then
  # retrieve old IG's output (necessary for detecting resource changes)
  log_simple "clone ${TERMGIT_HTML_PROJECT} containing old IG's output"
  git clone https://gitlab-ci-token:${CI_JOB_TOKEN}@gitlab.com/${TERMGIT_HTML_PROJECT}.git ./termgit-html-project || exit 1

  log "RUN IGVer"

  # make sure ./termgit-html-project/output exists
  mkdir -pv ./termgit-html-project/output/

  # Git SHA of the last commit within this repository (required for creating the downloads)
  # https://www.systutorials.com/how-to-get-the-latest-commits-hash-in-git/
  git log --pretty=%H -1 > tmp_currentCommit.txt
  tr -d '\n' < tmp_currentCommit.txt > currentCommit.txt

  # retrieve terminologiesMetadata.csv from the last successful pipeline run
  git show $(cat lastSuccessfulPipeline.txt):terminologies/terminologiesMetadata.csv > old_terminologiesMetadata.csv

  # copy igVer.py along with required resources to termgit-html-project/output where it will detect if resources have been changed
  log_simple "copy IGVer (+ required module) old IG's output"
  cp -v ./igVer.py ./termgit-html-project/output/
  cp -v ./file_name_and_extension_extractor.py ./termgit-html-project/output/
  log_simple "copy data required for IGVer's execution"
  cp -v ./currentCommit.txt ./termgit-html-project/output/
  cp -v ./old_terminologiesMetadata.csv ./termgit-html-project/output/
  cp -v ./processedTerminologies.csv ./termgit-html-project/output/

  # change into directory of old IG output
  log_simple "change to old IG's output directory"
  echo pwd: $PWD
  cd termgit-html-project/output
  echo pwd: $PWD

  # execute IGVer for detecting changed resources
  log_simple "run IGVer"
  python igVer.py || exit 1
  log_simple "finished IGVer"

  # change into root directory
  log_simple "change into root directory"
  echo pwd: $PWD
  cd ../..
  echo pwd: $PWD

  # remove all content from termgit-html-project
  log_simple "Remove old content from termgit-html-project"
  echo log_appendix/delete_termgit-html-project.log
  rm -rvf ./termgit-html-project > log_appendix/delete_termgit-html-project.log

  # copy input/redirects to output
  log_simple "copy input/redirects for canonicals to output"
  cp -vR ./input/redirects/* ./old/
  rm -rvf ./input/redirects > log_appendix/created_redirect_files.log

  log "IGVer FINISHED"
else
  log "Prepare includes for integration test"
  # create list of terminologies within "terminologies/CodeSystem*" and "terminologies/ValueSet*" directories
  find terminologies/CodeSystem* terminologies/ValueSet* -type f > resource_file_path_list.txt

  echo log_appendix/prepare_includes_integration_test.log
  python prepare_includes_integration_test.py > log_appendix/prepare_includes_integration_test.log || exit 1

  echo log_appendix/git_status_integration_test.log
  git status > log_appendix/git_status_integration_test.log
  log "Prepare includes for integration test finished"
fi

log "CREATE IG"

log_simple "copy arch_and_setup_*.md to their corresponding index.md and index_en.md"

# if ./input/pagecontent/index.md does not exist, copy ./input/pagecontent/technical_documentation_*.md to ./input/pagecontent/index*.md
[ ! -f "./input/pagecontent/index.md" ] && cp "./input/pagecontent/technical_documentation_de.md" "./input/pagecontent/index.md" && log_simple "copy ./input/pagecontent/technical_documentation_de.md to ./input/pagecontent/index.md"
[ ! -f "./input/pagecontent/index_en.md" ] && cp "./input/pagecontent/technical_documentation_en.md" "./input/pagecontent/index_en.md" && log_simple "copy ./input/pagecontent/technical_documentation_en.md to ./input/pagecontent/index_en.md"

# - if the current branch IS NOT the default branch
#   AND if the param CI_DO_FULL_IGPUB_CREATION IS NOT set, do a differential run of IG publisher
# - if the current branch is NOT the default branch
#   AND if the param CI_DO_FULL_IGPUB_CREATION IS set, do a full run of IG publisher
# - if the current branch IS the default branch, do a full run of IG publisher
#
# for checking env variable, this was used: https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [[ $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH ]] && [[ -z ${CI_DO_FULL_IGPUB_CREATION_IN_BRANCH+x} ]]
then
  # copy .4.fhir.json files that had been changed in the initiating commit to ./input/resources
  log_simple "copy .4.fhir.json files that had been changed in the initiating commit to ./input/resources"
  mkdir -pv './input/resources'
  echo log_appendix/copy_4.fhir.json_to_resources.log
  touch log_appendix/copy_4.fhir.json_to_resources.log
  # move all files in the list to terminologies (from https://superuser.com/questions/538306/move-a-list-of-filesin-a-text-file-to-a-directory)
  for file in $(cat terminology_file_paths.txt); do
      dir=$(dirname "$file")
      find $dir -name '*.4.fhir.json' -exec cp -prv '{}' './input/resources' ';' >> log_appendix/copy_4.fhir.json_to_resources.log
  done
else
  # reset folder for resources of IG-Pub and copy all .4.fhir.json files in all subdirectories
  log_simple "copy .4.fhir.json files to ./input/resources"
  mkdir -pv './input/resources'
  echo log_appendix/copy_4.fhir.json_to_resources.log
  find ./terminologies/ -name '*.4.fhir.json' -exec cp -prv '{}' './input/resources' ';' > log_appendix/copy_4.fhir.json_to_resources.log
fi

# Remove '.4.fhir' from file names in order to make them detectable by IG publisher
log_simple "remove '.4.fhir' from file names"
echo log_appendix/rename_4.fhir.json_to_json.log
find ./input/resources -type f -name '*.4.fhir.json' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e 's/.4.fhir//')" ;
    mv -v "${FILE}" "${newfile}" >> log_appendix/rename_4.fhir.json_to_json.log ;
done

# Log which files the directory input/resources contains
log_simple "Files within input/resources (to be processed by IG publisher)"
ls ./input/resources

# set canoncial for Implementation Guide resource
log_simple "set canoncial to: $TERMGIT_CANONICAL"
sed -i "s|TERMGIT_CANONICAL|$TERMGIT_CANONICAL|" sushi-config.yaml
log_simple "canonical has been set"

log_simple "prepare pagecontent for IG publisher"
# replace all ".md" with ".html" in order to have working links in IG
sed -i "s|\.md|\.html|gI" input/pagecontent/*
# replace all "(input/files" with "(files" to have working file references
sed -i "s|(input/files|(files|gI" input/pagecontent/*
# replace all "(input/images" with "(images" to have working image references
sed -i "s|(input/images/|(|gI" input/pagecontent/*
log_simple "pagecontent successfully prepared"

# run sushi for creating ImplementationGuid resource
log_simple "run sushi"
sushi || exit 1
log_simple "sushi finished"

# if IG_PUBLISHER_URL is set use the value of the environment variable and download the IG publisher from there
if ! [[ -z "$IG_PUBLISHER_URL" ]];
then
  # download IG publisher
  log_simple "download IG publisher"
  curl -L ${IG_PUBLISHER_URL} -o "$PWD/input-cache/publisher.jar" --create-dirs
  log_simple "IG publisher downloaded"
else
  # copy the IG publisher provided in the docker container
  log_simple "copy IG publisher"
  # make sure ./input-cache/ exists
  mkdir -pv ./input-cache/
  # copy IG publisher
  cp -v /opt/publisher.jar ./input-cache/publisher.jar
  log_simple "IG publisher copied"
fi

# run IG publisher:
log_simple "run IG publisher"
unset DISPLAY
# IG publisher will be executed. If executtion of IG publisher fails, this script will fail and, thus, the pipeline as well.
./_genonce.sh || exit 1
log_simple "IG publisher finished"

# increase stack size
# https://stackoverflow.com/questions/10035541/what-causes-a-python-segmentation-fault
# relevant especially for: ConceptMap-snomed-orphanet-mapping.xml (reason could not be determined)
ulimit -s 32768

log_simple "activate previous version links"
# remove all "<!--COMMENTED-PREVIOUS-VERSION-INCLUDE" and "COMMENTED-PREVIOUS-VERSION-INCLUDE-->" in order to activate the previous version links
sed -i "s|<!--COMMENTED-PREVIOUS-VERSION-INCLUDE||gI" output/*.previous-versions.html
sed -i "s|COMMENTED-PREVIOUS-VERSION-INCLUDE-->||gI" output/*.previous-versions.html
log_simple "previous version links activated"

# minify all HTML files created by IG publisher
log_simple "minify HTML files"
echo log_appendix/minify_html_output.log
python minify_html_output.py > log_appendix/minify_html_output.log || exit 1

# copy content from "./old" (contains redirects and all old versions of resources) to "./output"
log_simple "copy old versions to output directory"
echo log_appendix/copy_old_to_output.log
cp -vR ./old/* ./output/ > log_appendix/copy_old_to_output.log

# create sitemap
log_simple "create and copy information about sitemap to output directory"
python sitemap_generator.py || exit 1
cp -v ./input/sitemap/* ./output/

# Copy new redirects files in order to be committed properly
log_simple "copy new redirects files in order to be committed"
cat copy_created_redirects.txt
mkdir -pv ./input/redirects/CodeSystem
mkdir -pv ./input/redirects/ValueSet
while read -r line
do
  eval $line
done < copy_created_redirects.txt

log "IG CREATED"

# for integration tests (triggered by another pipeline) no input/include will not be updated
if [[ $CI_PIPELINE_SOURCE != "pipeline" ]]
then
  log "UPDATE input/includes"

  # stage ./input/sitemap
  git add "./input/sitemap"
  # stage ./input/includes
  git add "./input/includes/*-download.xhtml"
  # stage new previous versions if existent
  git add $(cat new_previous_versions_files.txt)
  gitCommitMessage="${AUTOMATIC_COMMIT_PREFIX} update sitemap, downloads"

  # if the job is executed in default branch stage *-previous-versions.xhtml as well:
  if [[ $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH ]]
  then
    git add "./input/includes/*-previous-versions.xhtml"
    gitCommitMessage="${gitCommitMessage}, and previous versions"
  fi
  git status
  git commit -m "${gitCommitMessage}"
  git push "https://${GITLAB_USER_LOGIN}:${GITLAB_CI_TOKEN}@gitlab.com/${CI_PROJECT_PATH}.git" HEAD:${CI_COMMIT_BRANCH} || exit 1

  log "FINISHED UPDATE input/includes"
else
  log "input/includes not updated: pipeline source = ${CI_PIPELINE_SOURCE}"
fi

# move files that should not be published to a separate directory for them to be available if needed
mkdir removed_from_output
mv -v ./output/*.db ./output/*.zip ./output/*.tgz ./output/*.xlsx ./output/*.pack ./output/expansions.* ./output/qa.min.html ./output/qa.xml ./output/qa.txt ./output/qa.html ./output/qa-tx.html ./output/qa-eslintcompact.txt ./output/qa-time-report.json ./removed_from_output/

log "END OF create-terminologit.sh"
