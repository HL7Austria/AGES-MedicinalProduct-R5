> **Für die deutsche Version bitte [hier](quickstart_de.md) klicken.**

The following instructions allow to quickly set up your own TerminoloGit based on GitLab.com.

### Prerequisites

- GitLab.com user account.
  - **Note:** As your username will be used as part of a CI/CD variable key it has to fulfil the [requirements for CI/CD variables](https://docs.gitlab.com/ee/ci/variables/#for-a-project), hence, it must be one line, with no spaces, using only letters, numbers, or `_`.
  - **Note:** When creating a new user account you may be [required to perform a credit or debit card validation to use shared runners on GitLab.com](https://about.gitlab.com/blog/2021/05/17/prevent-crypto-mining-abuse/). If necessary, the corresponding information will pop up as soon as you try to start your first pipeline.

### Setup

1. Create a **private** fork from
   - https://gitlab.com/elga-gmbh/termgit-dev
   - https://gitlab.com/elga-gmbh/terminologit-dev-html
   - If you need all terminologies published on the Austrian e-Health terminology browser, fork from https://gitlab.com/elga-gmbh/termgit and https://gitlab.com/elga-gmbh/termgit-html (due to the size of terminologies this will only work with [non-free 32GB runners](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html)!)
1. Configuration for your `terminologit-dev-html` project
   1. Enhance the [inbound job token scope allowlist](https://docs.gitlab.com/ee/ci/jobs/ci_job_token.html#add-a-project-to-the-inbound-job-token-scope-allowlist)
      1. Go to **Settings > CI/CD** and expand the **Token Access** section
      2. Under **Allow CI job tokens from the following projects to access this project**, add `[username]/termgit-dev` to the allowlist.
2. Configuration for your `termgit-dev` project
   1. Create / Configure the following CI/CD variables as minimum requirement at your `termgit-dev` project's **Settings > CI/CD** and expand the **Variables** section. You can find the full [list of configurable CI/CD variables](setup_en.md#cicd-variables) in the documentation.

        | Key | Value | Type | Environment scope | Protect variable | Mask variable | Expand variable reference |
        | --- | --- | --- | --- | --- | --- | --- |
        | `[username]_GITLAB_CI_TOKEN` <br/><br/> Use your GitLab.com username as part of the CI/CD variable name. | Create a [personal access token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token) with the scopes `api` and `read_user` | `Variable` | `All` | no | **yes** | no |
        | `RUNNER_TAG` | Depending on your GitLab.com plan you can choose between the following [SaaS runners on Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html), e.g. `saas-linux-medium-amd64`. | `Variable` | `All` | no | no | no |
        | `RUNNER_TAG_FOR_IG_RUN` | Used only for the `run_ig` Job. Depending on your GitLab.com plan you can choose between the following [SaaS runners on Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html), e.g. `saas-linux-medium-amd64`. | `Variable` | `All` | no | no | no |
        | `TERMGIT_CANONICAL` | `https://[username].gitlab.io/termgit-dev` | `Variable` | `All` | no | no | no |
        | `TERMGIT_HTML_PROJECT` | `[username]/terminologit-dev-html` | `Variable` | `All` | no | no | no |
        | `TERMGIT_HTML_PROJECT_DEFAULT_BRANCH` | `master` | `Variable` | `All` | no | no | no |
   2. Create first publication by running a pipeline manually, hence, simulating a Git commit.
      1. Go to **CI/CD**, then **Pipelines**, and then click on **Run pipeline**
      2. Add a CI/CD variable named `CI_COMMIT_TITLE` having an arbitrary value, e.g. `test`.
      3. Click on **Run pipeline**.
      4. Observe your Pipeline run and enjoy your first published TerminoloGit under `https://[username].gitlab.io/termgit-dev` or `https://[username].gitlab.io/terminologit-dev-html`

Further information regarding all supported CI/CD variables can be found within the [setup](setup_en.md).