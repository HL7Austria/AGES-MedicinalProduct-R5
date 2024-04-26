import os
from subprocess import Popen, PIPE, STDOUT
from git_pipeline_hash_detector import hash_detector

# retrieve commit sha from wich the git log should be started
pipeline_sha = hash_detector(os.environ['CI_PROJECT_ID'])

if (pipeline_sha != ""):
  # get all changes from the last successful pipeline run till now within "terminologies/CodeSystem*" and "terminologies/ValueSet*" directories
  process = Popen(["git","log",pipeline_sha + "..HEAD","--name-only","--pretty=","terminologies/CodeSystem*","terminologies/ValueSet*"], stdout=PIPE, stderr=STDOUT, bufsize=1)
  with process.stdout:
    # automatically decode as utf-8 and remove \n
    git_log = [x.decode('utf8')[:-1] for x in process.stdout.readlines()]
else:
  # get all changes for the whole git log within "terminologies/CodeSystem*" and "terminologies/ValueSet*" directories
  process = Popen(["git","log","--name-only","--pretty=","terminologies/CodeSystem*","terminologies/ValueSet*"], stdout=PIPE, stderr=STDOUT, bufsize=1)
  with process.stdout:
    # automatically decode as utf-8 and remove \n
    git_log = [x.decode('utf8')[:-1] for x in process.stdout.readlines()]

# eliminate duplicate entries from git_log
git_log = list(dict.fromkeys(git_log))

# write paths of changed terminologies to file
with open("terminology_file_paths.txt", "w") as file:
  file_lines = "\n".join(git_log)
  file.write(file_lines)

# write Git-hash of last successful pipeline run
with open("lastSuccessfulPipeline.txt", "w") as file:
  file.write(pipeline_sha)