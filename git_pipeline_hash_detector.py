import json, os
from subprocess import Popen, PIPE, STDOUT

def hash_detector(project_id):
    # retrieve all commit hashes of the branch currently checked out
    process = Popen(["git", "log", "--pretty=%H"], stdout=PIPE, stderr=STDOUT)
    with process.stdout:
        # automatically decode as utf-8 and remove \n
        git_commit_sha_list = [x.decode('utf8')[:-1] for x in process.stdout.readlines()]

    # retrieve information about all successful pipelines
    process = Popen(["curl", "--silent", "https://gitlab.com/api/v4/projects/"+project_id+"/pipelines?status=success", "--header", "PRIVATE-TOKEN:" + os.environ["GITLAB_CI_TOKEN"]], stdout=PIPE, stderr=STDOUT)
    with process.stdout:
        gitlab_pipeline_json_list = json.load(process.stdout)

    # retrieve the commit hash for the most recent pipeline that is part of the current branch's history
    pipeline_sha = ""
    if os.environ["CI_DEFAULT_BRANCH"] == os.environ["CI_COMMIT_BRANCH"]:
        # If the current branch is the default branch the last successful pipeline of the default branch shall be determined.
        # With that it is guaranteed, that changes of other branches will be detected properly and result in properly updated previous-versions.
        for gitlab_pipeline_json in gitlab_pipeline_json_list:
            if gitlab_pipeline_json["ref"] == os.environ["CI_COMMIT_BRANCH"] and gitlab_pipeline_json["sha"] in git_commit_sha_list:
                pipeline_sha=gitlab_pipeline_json["sha"]
                break
    else:
        # If the current branch is NOT the default branch the last successful pipeline shall be determined.
        # With that the most recent changes will be part of the next pipeline run.
        for gitlab_pipeline_json in gitlab_pipeline_json_list:
            if gitlab_pipeline_json["sha"] in git_commit_sha_list:
                pipeline_sha=gitlab_pipeline_json["sha"]
                break

    print("commit sha of last pipeline run: " + pipeline_sha)

    # if a successful pipeline exists for the current branch's history
    if pipeline_sha != "":
        # move from the pipeline commit to the next commit, which should be a commit with a title starting with "AUTOMATIC_COMMIT"
        # INFO: more current commit sha are at the start of the git_commit_sha_list
        sha_index = git_commit_sha_list.index(pipeline_sha) - 1

        # move along to the more current commits until a non "AUTOMATIC_COMMIT" is found
        while sha_index >= 0:
            commit_sha = git_commit_sha_list[sha_index]
            print("commit sha currently checked: " + commit_sha)

            # retrieve further information about the commit
            process = Popen(["curl", "--silent", "https://gitlab.com/api/v4/projects/"+project_id+"/repository/commits/" + commit_sha, "--header", "PRIVATE-TOKEN:" + os.environ["GITLAB_CI_TOKEN"]], stdout=PIPE, stderr=STDOUT)
            with process.stdout:
                gitlab_commit_json = json.load(process.stdout)

            print("------------------------")
            print(gitlab_commit_json)
            print("------------------------")


            if gitlab_commit_json["title"].startswith(os.environ["AUTOMATIC_COMMIT_PREFIX"]):
                pipeline_sha = commit_sha
            else:
                break
            # move to the more current commit
            sha_index-=1

        print("commit sha for last successful pipeline: " + pipeline_sha)
        return pipeline_sha
    else:
        # no pipeline sha could be determined
        print("no pipeline sha could be determined")
        return ""

if __name__ == "__main__":
    print(hash_detector())
