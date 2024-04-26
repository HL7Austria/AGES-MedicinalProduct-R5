> **Für die deutsche Version bitte [hier](architecture_de.md) klicken.**

For better understanding of the architecture of TerminoloGit basic knowledge of the following technologies and/or systems is assumed:
- Git
  - Branching and merging
  - Tags
  - Git logs
- GitLab
  - Merge requests
  - CI/CD
- HL7® FHIR®
  - REST API
- HL7® FHIR® IG Publisher

### TerminoloGit and its components

TerminoloGit is an open source project that is made up of multiple interacting repositories, initialized by the Austrian ELGA GmbH.

- [TerminoloGit Dev](https://gitlab.com/elga-gmbh/termgit-dev)
- [TerminoloGit Dev HTML](https://gitlab.com/elga-gmbh/terminologit-dev-html) - Hosts created static HTML pages enabling versioning of terminologies.
- [MaLaC-CT (also standalone)](https://gitlab.com/elga-gmbh/malac-ct) - Converts between supported [file formats](file_formats_en.md).
- [TerminoloGit Template](https://gitlab.com/elga-gmbh/terminologit-template) - Formats static HTML pages.
- [fsh-ing-grounds](https://gitlab.com/elga-gmbh/docker/fsh-ing-grounds) or [docker image elgagmbh/fsh-ing-grounds](https://hub.docker.com/r/elgagmbh/fsh-ing-grounds) - Docker image prepared to run the [HL7® FHIR® IG Publisher](https://github.com/HL7/fhir-ig-publisher)
- _external_ [HL7® FHIR® IG Publisher](https://github.com/HL7/fhir-ig-publisher) - Used to generate static HTML pages.

#### TerminoloGit and FHIR® Server

If TerminoloGit shall be used in connection with a FHIR® server, please take a look at the project [TerminoloGit tergi](https://gitlab.com/elga-gmbh/terminologit-tergi) which allows to set up a fully-fledged FHIR® server complemented with a lightweight Git repository.

### Structure of the repository

This chapter briefly explains the structure of a TerminoloGit repository:
- `.` - contains the `README`, the `CODE_OF_CONDUCT`, the `CONTRIBUTING`, the `CHANGELOG`, the `LICENSE`, as well as a lot of scripts used throughout a pipeline run.
- `input/files/` - contains some templates to be used for terminology creation.
- `input/fsh/` - kept to tell TerminoloGit users that no `fsh` files shall be put into that directory.
- `input/images/` - images which are used within the documentation.
- `input/includes/` - for each terminology a fragment for its downloads and its previous versions is provided in this directory. These fragments will later be processed by the TerminoloGit template.
- `input/pagecontent/` - several markdown files that form the documentation of TerminoloGit.
- `input/redirects/` - for each terminology a redirects file exists which allows to access the terminologies based on their canonical.
- `input/resources/` - FHIR® resources which shall not be processed by MaLaC-CT are placed in this directory, e.g. ConceptMaps or intensional ValueSets.
- `input/sitemap/` - Meta-information for web crawler where to find the sitemap and which pages shall be indexed.
- `terminologies/` - for each terminology a directory exists (pattern `[CodeSystem | ValueSet]-[id]`). Furthermore, it contains the `terminologiesMetadata.csv`.

The `terminologies/terminologiesMeta.csv` contains some important meta-information about all terminologies which are managed by TerminoloGit:
1. `name` - `[CodeSystem | ValueSet]-[id]`
2. `canonical` - `[TERMGIT_CANONICAL]/[CodeSystem | ValueSet]/[id]`
3. `oid` - OID of the terminology
4. `version` - version of the terminology
5. `id` - the terminology's `id`
6. `type` - `[CodeSystem | ValueSet]`
7. `metadata-change-timestamp` - the time of the last change of the terminology metadata.

### CI/CD flow

The CI/CD pipeline in TerminoloGit consists of several stages and its corresponding jobs and is structured as follows. Please note, that neither all stages nor all jobs are executed in every pipeline, however, rules control which will be executed.
- Stage `manual_trigger`
  - Job `manual_trigger` - A manual trigger to start the pipeline in branches apart from the default branch. On the default branch the pipeline will start automatically upon a push of new commits.
- Stage `check_variables`
  - Job `check_variables` - Check if the required environment variables are set.
- Stage `run_malac-ct` - Depending on the circumstances one of the following jobs will be executed.
  - Job `run_malac-ct` - This job automatically detects new/updated terminologies within the `terminologies/` directory and will convert them to all file formats by using MaLaC-CT.
  - Job `run_malac-ct_integration_test` - This job is not part of the default pipeline in a TerminoloGit project. It can be triggered from within a MaLaC-CT repository and will then run instead of the usual `run_malac-ct`. It converts all existing terminologies of a specified TerminoloGit repository using a specified file format as source.
  - Job `skip_malac-ct` - This job can be triggered if a commit is prepended with `SKIP_MALAC`. As a result, no terminology will be processed by MaLaC-CT. *Note, currently new business versions will NOT be detected in this case.*
- Stage `run_ig`
  - Job `run_ig` - This job handles the creation of previous versions (except for pipelines started with a `SKIP_MALAC` commit) and starts the HL7® FHIR® IG Publisher which creates the static HTML pages.
- Stage `update_html` - On the default branch `update_html_full_content` will always be executed. On other branches `update_html_with_diff` will be executed.
  - Job `update_html_full_content` - The result of `run_ig` will update the `TERMGIT_HTML_PROJECT_DEFAULT_BRANCH` within the `TERMGIT_HTML_PROJECT` project.
  - Job `update_html_with_diff` - The result of `run_ig` will be pushed to the `TERMGIT_HTML_PROJECT`. The branch name will be the same as in the TerminoloGit project.
- Stage `publish` - The following jobs run in parallel.
  - Job `pages` - Updates the GitLab pages of the TerminoloGit project.
  - Job `upload_input_resources` - Uploads all resources within the `input/resources/` directory to the given FHIR® servers.

The following is a visualization of the three most common flows of the CI/CD pipeline. For details, refer to the `.gitlab-ci.yml`.

#### Standard terminology maintenance

[![CI-CD-standard](input/images/CICD_standard.drawio.png){: style="width: 100%"}](input/images/CICD_standard.drawio.png)

#### Integration test

[![CI-CD-integration-test](input/images/CICD_integration_test.drawio.png){: style="width: 100%"}](input/images/CICD_integration_test.drawio.png)

#### SKIP_MALAC

[![CI-CD-skip-malac](input/images/CICD_skip_malac.drawio.png){: style="width: 100%"}](input/images/CICD_skip_malac.drawio.png)

### Fully dressed use case diagram

The entire concept is shown in a fully dressed use case diagram, below the written use cases at subfunction/fish level can be found. Please note, this diagram is not fully compliant to the Cockburn diagram for fully dressed use case diagrams. A few changes have been made to show all the needed information in one diagram.

[![fully dressed use case diagram](input/images/FullyDressedUseCaseDiagramm.drawio.png){: style="width: 100%"}](input/images/FullyDressedUseCaseDiagramm.drawio.png)

**Parameters for all use cases:**

1. **Actors:**
   - only differentiated between GitLab roles and the GitLab service itself, additional roles can be set per governance in each production system
1. **Scope:**
   - a terminology like a code system or value set
1. **Level:**
   - Subfunction/Fish

#### \#1 Create Account, Authenticate and Authorise

1. **Actors:**
   - Guest (human)
   - Service (machine)
1. **Brief:** A guest needs a GitLab account for special interactions (e.g. subscribing to a tag of a terminology via GitLab) and creates one via GitLab.
1. **Postconditions:**
   1. **Minimal Guarantees:** none
   2. **Success Guarantees:**
      - A user account has been created
2. **Preconditions:**
   - The GitLab projects needed for TerminoloGit have been created
3. **Triggers:**
   - A guest wants to perform a special interaction
4. **Basic flow:**
   1. Creating an account on GitLab and if needed requesting individual permissions
   2. Login in GitLab
5. **Extensions:** none
6. **Software:**
   - Any browser
7. **Hardware:**
   - Any client with a browser
8.  **Services:**
   - GitLab.com or own GitLab CE hosting

#### \#2 Subscription

1. **Actors:**
   - Service (machine)
   - Subscriber (human - a guest that subscribed to some terminologies)
1. **Brief:** The subscribers are being informed automatically via e-mail, because a new or edited terminology file has been pushed.
1. **Postconditions:**
   1. **Minimal Guarantees:** none
   2. **Success Guarantees:**
      - A subscriber is being informed of a new terminology
1. **Preconditions:**
   - A guest has subscribed to the GitLab project TerminoloGit
2. **Triggers:**
   - A terminology has been added or updated
3. **Basic flow:**
   1. GitLab sends the change to all subscribers
4. **Extensions:** none
5. **Software:**
   - Any e-mail program
6. **Hardware:**
   - Any client with an e-mail program
7. **Services:**
   - GitLab for sending the change to subscribers

#### \#3 Using FHIR® IG and FHIR-tx

1. **Actors:**
   - Guest (human or machine)
   - Service (machine)
1. **Brief:** A terminology like a code system or value set is being retrieved via the GitLab GUI, TerminoloGit GUI, GitLab REST API, or FHIR-tx REST API interface
1. **Postconditions:**
   1. **Minimal Guarantees:** none
   2. **Success Guarantees:**
      - if the terminology the guest is looking for exists
        - receiving a terminology
1. **Preconditions:**
   - The TerminoloGit GitLab project exists
   - The FHIR® IG is published
   - The FHIR-tx is up to date
1. **Triggers:**
   - A terminology needs to be retrieved
1. **Basic flow:**
   1. By requesting the FHIR® IG web site a guest gets a browsable format of all terminologies with the possibility to download them in any format
   1. By requesting the GitLab web site a guest gets a list of all formats of all terminologies with the possibility to download them
   2. By operating with FHIR® ValueSet or CodeSystems REST operations the terminologies are retrieved by a machine
   3. By operating with the GitLab REST API terminologies are retrieved by a machine
2. **Extensions:**
   - A validation of concepts in ValueSet or CodeSystem resources is possible with `$validate-code`.
   - A hierarchy status between two concepts in a CodeSystem is possible by `$subsumes`.
   - A detailed view of a concept in a CodeSystem is possible by `$lookup`.
3. **Software:**
   - A browser or REST client
4. **Hardware:**
   - Client for browsing or sending REST requests
5. **Services:**
   - GitLab for publishing terminologies
   - a FHIR® server for REST requests

#### \#4 CRUD and push a terminology to GitLab

1. **Actors:**
   - Developer (human)
   - Service (machine)
1. **Brief:** A new terminology file is being created or edited and pushed to the GitLab project
1. **Postconditions:**
   1. **Minimal Guarantees:**
      - some feedback what went wrong with the commit or push
   2. **Success Guarantees:**
      - The new, edited or as retired flagged terminology file is published in the TerminoloGit GitLab project. The CI/CD pipeline will be triggerd automaticly or manually
1. **Preconditions:**
   - The TerminoloGit GitLab project exists
   - A local Git client and an editor is installed on a client or a WebIDE of GitLab is being used
1. **Triggers:**
   - A terminology needs to be created or updated
1. **Basic flow:**
   1. With an editor (e.g. Notepad++, Visual Studio Code) or a WebIDE a terminology file in the local Git repository is being created, updated, or deleted by setting the status to retired.
   1. In your local Git client a new commit is being created and pushed to the remote TerminoloGit repository
1. **Extensions:**
   - A branch beside of the default branch could indicate that a new commit is pushed for testing or approval purposes. In this case the CI/CD of GitLab is the same as for the default branch with the only difference that the result is only visible on a seperate site.
1. **Software:**
   - a local Git client or a browser
   - an editor (e.g. Notepad++, Visual Studio Code) or a browser
2. **Hardware:**
   - Client for editing text files and Git pushing or browsing
3. **Services:**
   - GitLab for publishing terminologies

#### \#5 Continuous Delivery to FHIR® IG and FHIR-tx

1. **Actors:**
   - Service (machine)
1. **Brief:** A new or edited terminology file is being converted to other terminology formats from the GitLab service by a runner
1. **Postconditions:**
   1. **Minimal Guarantees:**
      - there is some CI/CD error
   2. **Success Guarantees:**
      - It's converted by MaLaC-CT, versioned the IGVer, rendered by the IG Publisher and shown on a gitlab page
1. **Preconditions:**
   - The TerminoloGit GitLab CI/CD is configured
1. **Triggers:**
   - A terminology has been added or updated
1. **Basic flow:**
   1. a GitLab runner for the CI/CD is being started because a new commit has been pushed
   2. the runner is converting the terminology to all other file formats
   3. if the conversion passed, the IGVer and afterwards the IG Publisher is started
   4. if the IG Publisher passed, the upload to FHIR-tx is starting
2. **Extensions:** none
3. **Software:** none
4. **Hardware:** none
5. **Services:**
    * GitLab for running the runner

#### \#6 Push to branches, approve and merge to master

1. **Actors:**
   - Developer (human)
   - Service (machine)
1. **Brief:** new or edited terminology files are being committed to a branch and requested for a merge to master.
1. **Postconditions:**
   1. **Minimal Guarantees:**
      - If a correction is needed:
        - waiting that the developer corrects with a new commit
   2. **Success Guarantees:**
      - a branch has been merged to master
1. **Preconditions:**
   - The TerminoloGit project is configured for branching
1. **Triggers:**
   - A terminology has been added or updated to a branch
1. **Basic flow:**
   1. the developer creates a branch for his commits
   1. the developer creates a commit with his changes
   1. the developer requests a merge to master or another protected branch
   1. another developer comments the request and demands changes or accepts this branch
   1. the developer merges it into master
1. **Extensions:** none
1. **Software:**
   - a browser
1. **Hardware:**
   - a machine with a browser
1. **Services:**
   - GitLab for running the runner

#### BigPicture

Knowing the architecture through the fully dressed use case diagram, the following BigPicture shows the different ways to use TerminoloGit, including the possible cascading system dependencies.

[![big-picture](input/images/BigPicture.drawio.png){: style="width: 100%"}](input/images/BigPicture.drawio.png)

Cascading synchronization between TerminoloGit instances is recommended through merge requests. You can create merge requests to and from every forked project, you can even [add fork relations afterwards](https://docs.gitlab.com/ee/api/projects.html#create-a-forked-fromto-relation-between-existing-projects). Beware that if there are some errors doing the post (like a 500 internal server error), you may have to [delete the old fork relation](https://docs.gitlab.com/ee/api/projects.html#delete-an-existing-forked-from-relationship) before.
You can also use the Git function Submodule or Subtree.
Furthermore, it is possible to automate the sync via CI/CD in your own system or via "mirroring" or "sync" features, if you do not perform any adaptations/extensions to the terminologies yourself.

Cascading synchronization between a TerminoloGit instance and a tergi instance has to be set up in your TerminoloGit instance, see [the README in the tergi repo](https://gitlab.com/elga-gmbh/terminologit-tergi) for more information.
