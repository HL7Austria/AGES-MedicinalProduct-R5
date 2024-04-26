> **Für die deutsche Version bitte [hier](setup_de.md) klicken.**

### Quickstart

Please refer to the [Quickstart](quickstart_en.md) for setting up your own TerminoloGit.

### Reset TerminoloGit

If you want to have a fresh start with TerminoloGit, it is advisable to delete all terminology related information from the forked project.

Refer to the description of [how to delete a terminology](use_cases_en.md#delete-a-terminology) in order to reset your TerminoloGit fork.

### Add Landing Page

TerminoloGit expects the following files:
- `input/pagecontent/index.md`
- `input/pagecontent/index_en.md`

The primary language is `de`, hence, `index.md` should contain the German version of the landing page. On the other hand, `index_en.md` should contain the English version of the landing page.

> Note, if one or both of these files are not provided they will automatically contain the content of `technical_documentation_de.md` and `technical_documentation_en.md`, respectively.

### CI/CD Variables

The following table lists all CI/CD variables that may be used to configure the functionality of TerminoloGit. Apart from the `Description` and `Required` columns the columns represent the fields required to be filled when creating a [CI/CD variable in GitLab](https://docs.gitlab.com/ee/ci/variables/).

| Key | Description | Required | Value (example) | Type | Environment scope | Protect variable | Mask variable | Expand variable reference |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `[username]_GITLAB_CI_TOKEN` <br/><br/> Use your GitLab.com username as part of the CI/CD variable name. | Allows to push certain results created within the pipelines to the repository. | **yes** | Create a [personal access token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token) with the scopes `api` and `read_user` | `Variable` | `All` | no | **yes** | no |
| `RUNNER_TAG` | Specifies which SaaS runner from GitLab.com will be used by the pipeline jobs. | **yes** | Depending on your GitLab.com plan you can choose between the following [SaaS runners on Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html), e.g. `saas-linux-medium-amd64`. | `Variable` | `All` | no | no | no |
| `RUNNER_TAG_FOR_IG_RUN` | Used only for the `run_ig` Job. Specifies which SaaS runner from GitLab.com will be used by the pipeline jobs. | **yes** | Depending on your GitLab.com plan you can choose between the following [SaaS runners on Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html), e.g. `saas-linux-medium-amd64`. | `Variable` | `All` | no | no | no |
| `TERMGIT_CANONICAL` | Specifies the canoncical URL for the created FHIR® IG and is being used as base URL for those terminologies that have not yet specified their own canonical. | **yes** | `https://[username].gitlab.io/termgit-dev` | `Variable` | `All` | no | no | no |
| `TERMGIT_HTML_PROJECT` | GitLab project path to the TerminoloGit HTML project that shall host the static HTML pages produced by the HL7® FHIR® IG publisher. | **yes** | `[username]/terminologit-dev-html` | `Variable` | `All` | no | no | no |
| `TERMGIT_HTML_PROJECT_DEFAULT_BRANCH` | Default branch of the TerminoloGit HTML project. | **yes** | `master` | `Variable` | `All` | no | no | no |
| `TERMGIT_BOT_CI_TOKEN` | [Personal access token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token) of a fallback GitLab user account which is allowed to execute push operations in case the user executing the pipeline lacks of required permissions. This comes handy in case of external terminology providers. | no | `imagine-this-is-a-token` | `Variable` | `All` | no | **yes** | no |
| `TERMGIT_BOT_USER_NAME` | GitLab user name of the fallback user. | Yes, if `TERMGIT_BOT_CI_TOKEN` is used. | `bot-name` | `Variable` | `All` | no | no | no |
| `TERMGIT_BOT_EMAIL` | E-Mail of the fallback user | Yes, if `TERMGIT_BOT_CI_TOKEN` is used. | `bot@email.com` | `Variable` | `All` | no | no | no |
| `IG_PUBLISHER_URL` | Use this to use a specific version of the [HL7® FHIR® IG Publisher](https://github.com/HL7/fhir-ig-publisher). If this variable is not set, the IG publisher which is shipped with the [docker image elgagmbh/fsh-ing-grounds](https://hub.docker.com/r/elgagmbh/fsh-ing-grounds) will be used. | no | current version: `https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar`<br/>specific version:`https://github.com/HL7/fhir-ig-publisher/releases/download/1.3.28/publisher.jar` | `Variable` | `All` | no | no | no |
| `GITLAB_CI_TOKEN` | Created by `create_gitlab_ci_token.sh` and contains the token used to push to other GitLab repositories. | *automatically created* | `some_CI_token` | `Variable` | `All` | no | no | no |
| `GITLAB_USER_OR_TERMGIT_BOT_EMAIL` | Created by `create_gitlab_ci_token.sh` and contains the e-mail address which will be used to configure Git within a job. | *automatically created* | `some@email.com` | `Variable` | `All` | no | no | no |
| `GITLAB_USER_OR_TERMGIT_BOT_NAME` | Created by `create_gitlab_ci_token.sh` and contains the user name which will be used to configure Git within a job. | *automatically created* | `some_user_name` | `Variable` | `All` | no | no | no |
| `CI_DO_FULL_IGPUB_CREATION_IN_BRANCH` | By default, only within the default branch all terminologies will be processed by the IG publisher. If this variable is set to any value, all terminologies will be processed by the IG publisher in any branch. | no | `true` | `Variable` | `All` | no | no | no |
| `TURN_OFF_VERIFICATION_IN_REST_CALLS` | If set to `true`, no certificate verification will be carried out. | no | `false` | `Variable` | `All` | no | no | no |
| `IG_PUB_TEMPLATE_URL` | URL of the repository hosting the template which is to be used for the IG publisher. If not specified `https://gitlab.com/elga-gmbh/terminologit-template.git` will be used. | no | `https://github.com/HL7/ig-template-base.git` | `Variable` | `All` | no | no | no |
| `IG_PUB_TEMPLATE_BRANCH` | Branch of the template repository (see `IG_PUB_TEMPLATE_URL`) which is to be used for the IG publisher. If not specified the respective default branch will be used. | no | `dev` | `Variable` | `All` | no | no | no |
| `JAVA_OPTS` | Allows to pass options to the Java call for the IG Publisher. | no | `-Xms13g -Xmx13g -XX:+UseG1GC` | `Variable` | `All` | no | no | no |


The following [CI/CD variables predefined by GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html) do also have an effect on TerminoloGit:

| Key | Description | Value (example) |
| --- | --- | --- |
| `CI_COMMIT_BRANCH` | The commit branch name. | `dev` |
| `CI_DEFAULT_BRANCH` | The name of the project’s default branch. | `main` |
| `CI_COMMIT_TITLE` | The full first line of the commit message, also known as commit title. Commit messages which start with `AUTOMATIC_COMMIT` shall not trigger a pipeline. Refer to the chapter explaining how to [start a pipeline](use_cases_en.md#start-a-pipeline) to see how a pipeline can be triggered without commit. | `Add terminology` |
| `CI_PIPELINE_SOURCE` | How the pipeline was triggered. | `push`, `pipeline`, etc. |
| `CI_JOB_TOKEN` | A token to authenticate with certain API endpoints. The token is valid as long as the job is running. Used for cloning other GitLab repositories. | `some_CI_token` |
| `GITLAB_USER_LOGIN` | The username of the user who started the pipeline, unless the job is a manual job. In manual jobs, the value is the username of the user who started the job. | `gitlab_user_name` |
| `CI_PROJECT_PATH` | The project namespace with the project name included. | `elga-gmbh/termgit-dev` |

#### Integration Test

For integration tests the following **additional** CI/CD variables are required.

| Key | Description | Required | Value (example) | Type | Environment scope | Protect variable | Mask variable | Expand variable reference |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `MALAC_CT_PROJECT` | GitLab project path of the MaLaC-CT project to be used for the integration test.  | **Yes**, if the pipeline has not been started within the MaLaC-CT project. | `elga-gmbh/malac-ct` | `Variable` | `All` | no | no | no |
| `MALAC_CT_PROJECT_BRANCH` | Branch of the MaLaC-CT project to be checked out for the integration test. | **Yes**, if the pipeline has not been started within the MaLaC-CT project. | `main` | `Variable` | `All` | no | no | no |
| `CS_INPUT_FORMAT` | [File format](file_formats_en.md) to be used as source for code systems by MaLaC-CT for creating all other file formats. | **Yes**, if the pipeline has not been started within the MaLaC-CT project. | `.1.propcsv.xlsx` | `Variable` | `All` | no | no | no |
| `VS_INPUT_FORMAT` | [File format](file_formats_en.md) to be used as source for value sets by MaLaC-CT for creating all other file formats. | **Yes**, if the pipeline has not been started within the MaLaC-CT project. | `.1.propcsv.xlsx` | `Variable` | `All` | no | no | no |
| `TERMGIT_TERMINOLOGIES_PROJECT` | GitLab project path of the TerminoloGit project whose terminologies will be used within the integration test. | **Yes**, if the pipeline has not been started within the MaLaC-CT project. | `elga-gmbh/termgit` | `Variable` | `All` | no | no | no |
| `TERMGIT_TERMINOLOGIES_PROJECT_BRANCH` | Branch of the TerminoloGit project whose terminologies will be used within the integration test. | **Yes**, if the pipeline has not been started within the MaLaC-CT project. | `main` | `Variable` | `All` | no | no | no |

The following [CI/CD variables predefined by GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html) do also have an effect on the integration test:

| Key | Description | Value (example) |
| --- | --- | --- |
| `CI_PIPELINE_SOURCE` | How the pipeline was triggered. | `pipeline` (required) |
| `CI_JOB_URL` | The job details URL. Used to create the download page of a terminology. | `https://some_url` |