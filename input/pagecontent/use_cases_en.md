> **Für die deutsche Version bitte [hier](use_cases_de.md) klicken.**

A rather general description of various use cases can be found here. Please note that this is not an exhaustive list of use cases. It shall only give you an impression of what is possible with TerminoloGit.

### Add a new terminology

**Code systems and extensional value sets** should be **[added to  `terminologies/` directory](#add-a-new-terminology-to-the-terminologies-directory)** in order to have it converted to all supported [file formats](file_formats_en.md) by MaLaC-CT.

**Intensional ValueSets and other FHIR® resources**, on the other hand, have to be **[added to `input/resources/` directory](#add-intensional-valuesets-or-other-fhir-resources-to-the-inputresources-directory)** as the are not supported by MaLaC-CT.

Additional configuration of TerminoloGit is recommended when **[adding a terminology with a different base URL](#add-terminologies-with-a-different-base-url)** within its canonical.

#### Add a new terminology to the terminologies/ directory

Code systems and extensional value sets should be added to the `terminologies/` directory in order to be converted to all other supported [file formats](file_formats_en.md) by MaLaC-CT.

> A new terminology can be created in any of the supported [file formats](file_formats_en.md). However, it is not recommended to use one of the deprecated file formats as in might result in information loss.

The following process describes how to add a new terminology based on the `.1.propcsv.xlsx` file format:
1. Download the **templates for a [Code System](input/files/CodeSystem-cs-import-template.1.propcsv.xlsx) or a [Value Set](input/files/ValueSet-vs-import-template.1.propcsv.xlsx)** for creating a new code system or value set, respectively. *Note: cells that have to be edited are highlighted in yellow.*
2. Once finished editing the file, rename it according to the following pattern:
   1. `[CodeSystem | ValueSet]-[id].1.propcsv.xlsx`
3. Create a new branch within the repository and continue working with it.
3. Create a new sub-directory within `terminologies/` according to the following pattern:
   1. `[CodeSystem | ValueSet]-[id]`
4. Place the `.1.propcsv.xlsx` file into the corresponding directory within the `terminologies/` directory. The resulting path should be the following:
   1. `terminologies/[CodeSystem | ValueSet]-[id]/[CodeSystem | ValueSet]-[id].1.propcsv.xlsx` e.g. `terminologies/CodeSystem-appc-anatomie/CodeSystem-appc-anatomie.1.propcsv.xlsx` or `terminologies/ValueSet-elga-laborparameter/ValueSet-elga-laborparameter.1.propcsv.xlsx`
5. Commit and push the changes to the new branch.
6. Create a merge request within GitLab.
7. Manually start the pipeline within GitLab.
8. Check the results of the pipeline - the following files should be created automatically by the pipeline:
   1.  `input/includes/`
       1.  `[CodeSystem | ValueSet]-[id]-download.xhtml`
       2.  `[CodeSystem | ValueSet]-[id]-previous-versions.xhtml`
   2.  `input/redirects/`
       1.  `[CodeSystem | ValueSet]/[id].html`
   3.  `terminologies/[CodeSystem | ValueSet]-[id]/`
       1.  all other file formats
9.  Once the pipeline has succeeded and the merge request has been approved (optional), it can be merged into the default branch.
10. On the default branch the pipeline will be started automatically.
11. The new terminology has been successfully published.

#### Add intensional ValueSets or other FHIR® resources to the input/resources/ directory

Intensional ValueSets or other FHIR® resources (as FHIR® XML or FHIR® JSON) have to be added to the `input/resources/` directory as they cannot be converted by MaLaC-CT.

Consider the following requirements:
- Additional files required by the TerminoloGit template for intensional ValueSets have to be created manually.

The following process describes how to add an intensional ValueSet or other FHIR® resources:
1. Create the intensional ValueSet or the FHIR® resource according to the FHIR® specification and save it within `input/resources/` according to the following pattern:
   1. `[FHIR® resource type]-[id].[xml | json]`
2. Create a new branch within the repository and continue working with it.
2. For intensional ValueSets create the following files:
   1. `input/includes/[CodeSystem | ValueSet]-[id]-download.xhtml` using the **[download template](input/files/download-template.xhtml)** by replacing `[CI_PROJECT_PATH]`, `[CI_DEFAULT_BRANCH]`, and `[CodeSystem | ValueSet]-[id]` accordingly. Furthermore, use the appropriate file extension `xml` or `json` depending on the format of the ValueSet.
   2. `input/includes/[CodeSystem | ValueSet]-[id]-previous-versions.xhtml` using the **[previous versions template](input/files/previous-versions-template.xhtml)**.
   3. `input/redirects/[CodeSystem | ValueSet]/[id].html` using the **<a href="files/redirects-template.html" download="redirects-template">redirects template</a>** by replacing `[TERMGIT_CANONICAL]` and `[CodeSystem | ValueSet]-[id]` accordingly.
3. For CodeSystems and ValueSets add a line to `terminologies/terminologiesMetadata.csv`
   1. `name` - `[CodeSystem | ValueSet]-[id]`
   2. `canonical` - `[TERMGIT_CANONICAL]/[CodeSystem | ValueSet]/[id]`
   3. `oid` - OID of the terminology
   4. `version` - version of the terminology
   5. `id` - `[id]`
   6. `type` - `[CodeSystem | ValueSet]`
   7. `metadata-change-timestamp` - the time of the last change of the terminology metadata.
4. Commit and push the changes to the new branch.
5. Create a merge request within GitLab.
6. Manually start the pipeline within GitLab.
7. Check the results of the pipeline.
8. Once the pipeline has succeeded and the merge request has been approved, it can be merged into the default branch.
9.  On the default branch the pipeline will be started automatically.
10. The intensional ValueSet or the FHIR® resource has been successfully published.

#### Add terminologies with a different base URL

It is possible to add terminologies which have a canonical URL whose base does not match the `TERMGIT_CANONICAL`, e.g. the `TERMGIT_CANONICAL` is `https://termgit.elga.gv.at` but the terminology's canonical is `http://terminology.hl7.org/ValueSet/v3-TargetAwareness`.

In such a case, follow the instructions as described above depending on which of them suits the resource to be added best, but additionally it is recommended to add the resources's canonical to the `sushi-config.yaml`:

    ...
    parameters:
      ...
      special-url:
        - http://terminology.hl7.org/ValueSet/v3-TargetAwareness
    ...

### Reference external code systems

It is possible that a value set is based on a code system which is included neither in `terminologies/` nor in `input/resources/`, e.g. `http://loinc.org` or `http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender`. In such a case, a manual entry in the `terminologies/terminologiesMetadata.csv` has to be added in order to guarantee a conversion of the value set to all file formats.

Add a line to `terminologies/terminologiesMetadata.csv`
   1. `name` - empty
   2. `canonical` - canonical of the referenced code system, e.g. `http://loinc.org` or `http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender`
   3. `oid` - OID of the terminology
   4. `version` - version of the terminology
   5. `id` - empty
   6. `type` - empty
   7. `metadata-change-timestamp` - empty

### Update a terminology

#### Update a terminology in the terminologies/ directory

Simply, any of the supported [file formats](file_formats_en.md) of a terminology within the `terminologies/` directory may be edited and commited in order to trigger an updated publication of the terminology.

If the business version of the terminology (`CodeSystem.version` or `ValueSet.version`, respectively) has been incremented, `IGver.py` will automatically create a previous version for the terminology.

#### Update a terminology in the input/resources/ directory

Simply, update the terminology within the `input/resources/` directory.

If a previous version shall be created for the updated terminology, this has to be done manually:
1. Within the project `TERMGIT_HTML_PROJECT`:
   1. Create a copy of the following files where `YYYYMMDD-hhmmss-` represents the date and time of the creation of the copy:
      1. `output/[CodeSystem | ValueSet]-[id].html` and create `output/YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].html`
      2. `output/[CodeSystem | ValueSet]-[id].download.html` and create `output/YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].download.html`
   2. Within the copied files add the following banner and replace `[CodeSystem | ValueSet]-[id]` accordingly:
      ```
      <div role="alert" class="alert alert-danger">
        <p id="publish-box">This is an outdated version that is no longer valid! You can access the <a href=[CodeSystem | ValueSet]-[id].html>current version here</a>.</p>
      </div>
      ```
   3. Commit and push the changes to `TERMGIT_HTML_PROJECT`.
2. Within the TerminoloGit project:
   1. Within `input/includes/[CodeSystem | ValueSet]-[id]-previous-versions.xhtml` create a new line according to the following pattern. `OLD_BUSINESS_VERSION` represents the business version of the outdated terminology.
      ```
      <tr><td><a href="YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].html">OLD_BUSINESS_VERSION</a></td><td><a onclick="createDiff('[CodeSystem | ValueSet]-[id].html', 'YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].html')" href="javascript:void(0);">Diff</a></td></tr>
      ```
   2. Commit and push the changes to the TerminoloGit project.

### Delete a terminology

> Before a terminology is deleted from TerminoloGit, consider setting its `status` to `retired` (see `CodeSystem.status` or `ValueSet.status`, respectively).

1. Within the project `TERMGIT_HTML_PROJECT`:
   1. Search and delete all files matching the following patterns. **Double check if the pattern includes files from terminologies that should not be deleted. Likewise, it might happen that the pattern does not capture all files belonging to the terminology which should be deleted.**
      1. `ls output/*[CodeSystem | ValueSet]-[id].*`
      2. `ls output/[CodeSystem | ValueSet]/[id].html`
   2. Commit and push the changes to the `TERMGIT_HTML_PROJECT`.
2. Within the TerminoloGit project:
   1. Search and delete the following files and directories:
      1. `input/includes/[CodeSystem | ValueSet]-[id]-previous-versions.xhtml`
      2. `input/includes/[CodeSystem | ValueSet]-[id]-download.xhtml`
      3. `input/redirects/[CodeSystem | ValueSet]/[id].html`
      4. `terminologies/[CodeSystem | ValueSet]-[id]/` **or** `input/resources/[CodeSystem | ValueSet]-[id].xml`
   2. Remove the entry corresponding to the deleted terminology from `terminologies/terminologiesMetadata.csv`
   3. Commit and push the changes to the TerminoloGit project.
3. Remove the terminology from any FHIR® server where it might have been uploaded.

### Start a pipeline

Basically, there are four ways how the GitLab pipeline can be started:
1. Pushing a commit to the default branch of the project.
2. Pushing a commit to any other branch of the project. Subsequently, the pipeline has to be started manually within GitLab (see [Add manual interaction to your pipeline](https://docs.gitlab.com/ee/ci/pipelines/#add-manual-interaction-to-your-pipeline)).
3. By starting a pipeline manually (see [Run a pipeline manually](https://docs.gitlab.com/ee/ci/pipelines/#run-a-pipeline-manually))
   1. The minimum requirement for a TerminoloGit pipeline to be started manually is to provide the `CI_COMMIT_TITLE`. By doing so a commit will be simulated.
4. By starting an integration test from a MaLaC-CT project.

### Browse terminologies

The HL7® FHIR® IG Publisher creates a set of static HTML pages. These pages are ideal for research purposes or simply for browsing, as all terminologies are presented in a well-structured HTML page. The user has the possibility to retrieve different code systems and value sets in a structured form or to search for specific concepts with the help of the search function. There is always a link between the code systems and value sets to make it easier to find terminologies that belong together.

### Import of terminologies

#### Automatic import of terminologies

To ensure that a system is always up to date, there are different options of automatically importing terminologies. The options presented here focus on importing a specific terminology.

Basically, the following URL template can always be used to retrieve the latest version of a terminology:

- For terminologies within the `terminologies/` directory:
  `[GITLAB_URL]/[PROJECT_PATH]/-/raw/[DEFAULT_BRANCH]/terminologies/[NAME_OF_TERMINOLOGY]/[NAME_OF_TERMINOLOGY][FORMAT]`
- For terminologies within the `input/resources/` directory:
  `[GITLAB_URL]/[PROJECT_PATH]/-/raw/[DEFAULT_BRANCH]/input/resources/[NAME_OF_TERMINOLOGY].xml`

Here the
- `[GITLAB_URL]` represents the URL used to access the GitLab instance which hosts the Git repository holding the terminologies (e.g. `https://gitlab.com`).
- `[PROJECT_PATH]` the path to the Git repository holding the terminologies (e.g. `elga-gmbh/termgit`).
- `[DEFAULT_BRANCH]` specifies the name of the default branch of the Git repository (e.g. `main`).
- `[NAME_OF_TERMINOLOGY]` corresponds to the type of the terminology (`CodeSystem` or `ValueSet`) and the id of the terminology (e.g. `iso-3166-1-alpha-3`). The type and id are linked with `-` resulting in `CodeSystem-iso-3166-1-alpha-3`.
- `[FORMAT]` corresponds to the file extension of one of the supported [file formats](file_formats_en.md), e.g. `.4.fhir.xml`.

The result then may look like this:

    https://gitlab.com/elga-gmbh/termgit/-/raw/main/terminologies/CodeSystem-iso-3166-1-alpha-3/CodeSystem-iso-3166-1-alpha-3.4.fhir.xml

Based on a particular file format of a terminology, different types of retrieval are presented in the next points. Note, the examples here are based on the Austrian terminology browser [termgit.elga.gv.at](https://termgit.elga.gv.at).
1. As a permalink to the file, without versioning details:
   - Python:

         response = urllib2.urlopen('https://gitlab.com/elga-gmbh/termgit/-/raw/main/terminologies/CodeSystem-iso-3166-1-alpha-3/CodeSystem-iso-3166-1-alpha-3.2.claml.xml?inline=false')
   - Java:

         URL url = new URL("https://gitlab.com/elga-gmbh/termgit/-/raw/main/terminologies/CodeSystem-iso-3166-1-alpha-3/CodeSystem-iso-3166-1-alpha-3.2.claml.xml?inline=false");
         URLConnection connection = url.openConnection();
         InputStream is = connection.getInputStream();
         // ... then download the file
2. With Git via ssh within a local repository and the Git-tags for the corresponding terminology:
   - First clone of the repository:

         git clone git@gitlab.com:elga-gmbh/termgit.git

   - Update of the local Git repository (incl. Git-tags):

         git fetch --tags -f

   - Checking the difference between current local directory content and that of the Git-tag of a terminology once the repository has been updated:

         git log HEAD..tags/CodeSystem-iso-3166-1-alpha-3

     or

         git log HEAD..tags/1.0.3166.1.2.3

   - Checkout the latest version of a terminology with the corresponding Git-tag. **Note:** This will set the entire repository to the state of the Git-tag. Other terminologies might have a more recent state.

         git checkout tags/CodeSystem-iso-3166-1-alpha-3

     or

         git checkout tags/1.0.3166.1.2.3

3. With Git via ssh without a local repository and the Git-tags for the corresponding terminology directory. All available download formats will be retrieved:

       git archive -o C:/tmp/CS-ISO-3166-1-alpha-3.zip --remote git@gitlab.com:elga-gmbh/termgit.git CodeSystem-iso-3166-1-alpha-3:terminologies/CodeSystem-iso-3166-1-alpha-3

   or

       git archive -o C:/tmp/CS-ISO-3166-1-alpha-3.zip --remote git@gitlab.com:elga-gmbh/termgit.git 1.0.3166.1.2.3:terminologies/CodeSystem-iso-3166-1-alpha-3

4. With GitLab API via REST for a specific download format (here `.2.claml.xml`). `/` needs to be escaped with `%2f`:

       curl https://gitlab.com/api/v4/projects/33179072/repository/files/terminologies%2fCodeSystem-iso-3166-1-alpha-3%2fCodeSystem-iso-3166-1-alpha-3.2.claml.xml?ref=main

5. Using FHIR® REST API when having a FHIR® server connected to the system:
   - curl:

         curl https://tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/iso-3166-1-alpha-3

   - for more details see [http://www.hl7.org/fhir/overview-dev.html#Interactions](http://www.hl7.org/fhir/overview-dev.html#Interactions)

##### Retrieving meta information of a Git-tag

The [GitLab API for Git Tags](https://docs.gitlab.com/ee/api/tags.html) can be used for automated checks whether a particular terminology has been updated. The following command can be used to retrieve the metadata of a Git-tag:

    curl https://gitlab.com/api/v4/projects/33179072/repository/tags/CodeSystem-iso-3166-1-alpha-3

Among other things, the metadata includes
- the current version of the terminology (`message`).
- the date the Git-tag was created (`created_at`).

#### Manual import of terminologies

In addition to the automatic import of terminologies, it is also possible to manually import all terminologies. For this, it is recommended to activate the tag news in GitLab. You will then receive an automatic notification for each change.

[![manual-import](input/images/manual_import_en.drawio.png "manual-import"){: style="width: 100%"}](input/images/manual_import_en.drawio.png)

### Validation of codes

The system can also be used to check whether a particular code is part of a code system or value set. This works with the FHIR® operation [`$validate-code` for CodeSystems](http://www.hl7.org/fhir/codesystem-operation-validate-code.html) and [`$validate-code` for ValueSets](http://www.hl7.org/fhir/valueset-operation-validate-code.html).

     curl https://tergi.elga.gv.at/fhir-server/api/v4/ValueSet/appc-anatomie/$validate-code?system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie&code=0

[![validate-code](input/images/validate-code.png){: style="width: 100%"}](input/images/validate-code.png)

If you are using the HAPI JPA server, please note the following limitations on the `$validate-code` FHIR® operation which is working according to the FHIR R4 specification:

* `[base]/CodeSystem/$validate-code` does not allow a trailing slash for the GET parameter `url` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/$validate-code?code=100&url=https://termgit.elga.gv.at/CodeSystem/elga-e-health-anwendungen)
* `[base]/CodeSystem/[id]/$validate-code` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/appc-anatomie/$validate-code?code=100)
* `[base]/ValueSet/$validate-code` does not allow a trailing slash for the GET parameters `url` and `system` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/$validate-code?url=https://termgit.elga.gv.at/ValueSet/appc-anatomie&code=0&system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie)
* `[base]/ValueSet/[id]/$validate-code` does not allow a trailing slash for the GET parameter `system` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/appc-anatomie/$validate-code?system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie&code=0)

### Further FHIR® operations with limitations by HAPI JPA Server

* `[base]/CodeSystem/$lookup` requires a trailing slash for the GET parameter `system` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/$lookup?code=100&system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie/)
* `[base]/ValueSet/$expand` does not allow a trailing slash for the GET parameter `url` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/$expand?url=https://termgit.elga.gv.at/ValueSet/appc-anatomie&system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie/)
* `[base]/ValueSet/[id]/$expand` (eg. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/appc-anatomie/$expand?system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie/)

### Upload terminologies to FHIR® servers

TerminoloGit managed resources can directly be uploaded to FHIR® servers. This can be accomplished by leveraging [GitLab's Project-level Secure Files](https://docs.gitlab.com/ee/ci/secure_files/).

Use the [template for specifying FHIR® server](input/files/additional-fhir-server-template.json), fill in the information required and create a file for each additional FHIR® server. The `FHIRServer` is madatory. You can choose between `User`+`UserPassword` or the `TergiTunnelToken`, please leave the unused variable empty with `""`. For more information about the variables look at the [setup](setup_en.md).

Now add the created file in your TerminoloGit instance:
[![Add a secure file in gitlab](input/images/tergi-sec-file.png "Add a secure file in gitlab"){: style="width: 100%"}](input/images/tergi-sec-file.png)

All new or updated terminologies or FHIR® resources located in the `input/resources` directory are subsequently loaded onto the additional FHIR® servers.