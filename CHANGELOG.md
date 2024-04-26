# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- elga-gmbh/termgit-dev#69 Reduce size of QA by using ignore warnings for those which can be ignored. Furthermore, the links to previous versions will be activated after the IG has been finished in order to prevent loads of link-errors.

## [2.7.0+20240404]

### Added

- Enable use of [replacedBy](http://hl7.org/fhir/StructureDefinition/codesystem-replacedby), [conceptOrder](http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder), [System OID](http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-valueset-systemoid) extension by activating the extension parameter. These extensions may also be used by leveraging "easy extensions" in `*.propcsv.*` and `*.spreadct.*`. formats.
- Add support for `.1.spreadct.xlsx`.
- elga-gmbh/termgit-dev#57 Introduce CI/CD variable for setting Java options and add its description to the documentation.
- Add conversion timestamp argument to parameter list.
- Add documentation of terminology operations on HAPI JPA server.

### Fixed

- Configuration in `sushi-config.yaml`.

## [2.6.0+20240206]

### Added

- elga-gmbh/termgit-dev#66 Upload of input/resources to FHIR server now also supports `.json` beside `.xml`.

### Fixed

- elga-gmbh/termgit-dev#61 Deactivate shallow clones of the repository in order to correctly identify terminologies to be processed by MaLaC-CT when merging old branches.
- elga-gmbh/termgit-dev#60 Use inline HTML to create download link for redirects template.
- elga-gmbh/termgit-dev#45 Fix link replacement and insertion of banner for previous versions.

## [2.5.1+20231114]

### Fixed

- Use fieldnames of read file for writing when preparing processed terminologies in case of `SKIP_MALAC`.

## [2.5.0+20231113]

### Added

- elga-gmbh/termgit-dev#54 Use other IG publisher templates per optional parameter (`IG_PUB_TEMPLATE_URL` and `IG_PUB_TEMPLATE_BRANCH`).

### Fixed

- elga-gmbh/termgit-dev#52 Prevent extra manual action because of one time errors by rerunning failed jobs up to two times.

### Changed

- Comprehensive update of the documentation.

## [2.4.6+20230921]

### Changed

- elga-gmbh/termgit-dev#53 Change order of file format priorities.

## [2.4.5+20230804]

### Fixed

- Fix erroneous copying of redirects of multiple new terminologies.

## [2.4.4+20230731]

### Fixed

- elga-gmbh/termgit-dev#41 Do full IG publisher runs in branches only if `CI_DO_FULL_IGPUB_CREATION_IN_BRANCH` is set.
- elga-gmbh/termgit-dev#40 Commit redirects files for new terminologies.

## [2.4.3+20230726]

### Fixed

- Solves upload of input/ressources, not altering the id/filename to lowercase anymore

## [2.4.2+20230725]

### Fixed

- Solves pages over 1GB, by deleting some more IG generated files that should not be published
- Solves upload of input/ressources for production system, setting from json to xml
- Solves upload_input_resources job running only on branch and normal commits

## [2.4.1+20230725]

### Changed

- elga-gmbh/termgit-dev#39 Move redirect file management outside of IG Publisher run

## [2.4.0+20230720]

### Added

- elga-gmbh/termgit-dev#24 Content within `input/resources` (e.g. concept maps, intensional value sets) are beeing published to specified FHIR servers.

### Fixed

- elga-gmbh/termgit-dev#32 Solves broken runs for the malac-ct integration test
- elga-gmbh/termgit-dev#26 Solves handling of the default branch, with no "only newly added terminologies"-handling, so that artifacts will be generated fully

## [2.3.1+20230522]

### Fixed

- Create missing `GITLAB_CI_TOKEN` when skipping MaLaC-CT.
- Preserve original toc.html.

## [2.3.0+20230508]

### Added

- #26 Solve that the IG Publisher newest version needs multiple hours instead of one for our 333 terminologies in production, by adding the feature of only rendering the newly added terminologies. Be aware, that with this version, no new terminologies can be added without manually altering the artifacts. This will be fixed in the next release.

## [2.2.0+20230307]

### Added

- Minify HTML files created by IG publisher by using [minify-html](https://github.com/wilsonzlin/minify-html).

## [2.1.1+20230223]

### Removed

- Installation of `gcompat` is no longer needed as it is included in the current version of `fsh-ing-grounds` docker image.

## [2.1.0+20230222]

### Added

- Add CI/CD variable in order to use MaLaC-CT's REST calls without verification.

## [2.0.2+20230216]

### Changed

- Remove toc from menubar, the artifacts summary should be used
- add sitemap.xml to gitignore for less merge conflicts

## [2.0.1+20230201]

### Fixed

- Enable upload to additional FHIR servers in default branch only.
- Check if directory `secure_files_4_fhir_upload` exists.

## [2.0.0+20230201]

### Added

- [TERGI-73](https://jira-neu.elga.gv.at/browse/TERGI-73) Upload possibility per secure files to multiple FHIR server and/or other than the FHIR server that is used for converting
- Created `CONTRIBUTING.md` & `CODE_OF_CONDUCT.md`, renamed some files and changed some connected references and information in other
- Allow transformation of `.4.fhir.xml` and `.4.fhir.json`.

### Changed

- #11 Switch to FHIR 4.3.0 (R4B).
- #15 Use annotated tags having a terminology's version as message instead of lightweight tags.
- [TERGI-107](https://jira-neu.elga.gv.at/browse/TERGI-107) Support `id` and `type` columns within `processedTerminologies.csv`. Add redirects for canoncial URLs.

## [1.5.0+20221215]

### Added

- Allow use of IG publisher shipped with `elgagmbh/fsh-ing-grounds` docker image.

## [1.4.0+20221205]

### Added

- [TERGI-135](https://jira-neu.elga.gv.at/browse/TERGI-135) Control if artifacts are uploaded from all branches or only from default branch with CI/CD variable `UPLOAD_ARTIFACTS_ALL_BRANCHES`.

### Fixed

- [TERGI-109](https://jira-neu.elga.gv.at/browse/TERGI-109) Changed URLs to images to `stable` branch.

## [1.3.0+20221201]

### Added

- [TERGI-122](https://jira-neu.elga.gv.at/browse/TERGI-122) Add support for setting specific runner by CI/CD variable `RUNNER_TAG`.
- [TERGI-131](https://jira-neu.elga.gv.at/browse/TERGI-131) Allow full configuration of integration test job.

## [1.2.0+20221115]

### Added

- [TERGI-119](https://jira-neu.elga.gv.at/browse/TERGI-119) Add support for `.1.propcsv.xlsx`.
- [TERGI-115](https://jira-neu.elga.gv.at/browse/TERGI-115) For users where it is not possible to require a GitLab CI token a dedicated GitLab bot-user may be configured to execute git commits/pushes throughout the pipeline.

### Fixed

- Fix creation of new previous version files in case multiple new terminologies have been added.

## [1.1.0+20221014]

### Added

- #3 Add `*.2.outdatedcsv.csv` explanation
- [TERGI-121](https://jira-neu.elga.gv.at/browse/TERGI-121) Allow configuration of IG Publisher version.

### Fixed

- Ignore stage `manual_trigger` when pipeline has been started as part of another pipeline.

## [1.0.0+20221010]

### Added

- [TERGI-116](https://jira-neu.elga.gv.at/browse/TERGI-116) Force manual pipeline triggering for branches which are not the default branch.

### Changed

- [TERGI-87](https://jira-neu.elga.gv.at/browse/TERGI-87) and [TERGI-67](https://jira-neu.elga.gv.at/browse/TERGI-67) Improve creation and display of previous versions. From now on, previous versions will only be created if the business version of a terminology (`ValueSet.version`, `CodeSystem.version`, etc.) has been changed.

## [0.13.0+20220929]

### Added

- [TERGI-73](https://jira-neu.elga.gv.at/browse/TERGI-73) Add support for new MaLaC-CT parameter `tergiTunnelToken` which allows access to all API endpoints of a tergi.

### Changed

- Resources in `input/resources` will not be deleted by default prior to IG Publisher invocation. As a result, e.g. `ConceptMap` resources may be included.

## [0.12.2+20220831]

### Fixed

- Fix URLs to images.

## [0.12.1+20220818]

### Added

- Additional stage in pipeline checking if required environment variables have got a value.

### Fixed

- [TERGI-100](https://jira-neu.elga.gv.at/browse/TERGI-100) Support creation and editing of terminologies in branches including merging them into the default branch.

## [0.12.0+20220729]

### Changed

- [TERGI-65](https://jira-neu.elga.gv.at/browse/TERGI-65) Pipeline fails if user lacks permissions for pushing to default branch or if CI/CD variable for the user has not been configured.
- [TERGI-69](https://jira-neu.elga.gv.at/browse/TERGI-69) Let pipeline fail if certain commands within `create-terminologit.sh` fail. Generally improve pipeline execution.

### Fixed

- [TERGI-38](https://jira-neu.elga.gv.at/browse/TERGI-38) Check if directories required for execution exist.

## [0.11.0+20220708]

### Changed

- [TERGI-88](https://jira-neu.elga.gv.at/browse/TERGI-88) Pipeline will fail if a terminology cannot be successfully converted by MaLaC-CT.
- [TERGI-14](https://jira-neu.elga.gv.at/browse/TERGI-14) New documentation structure, splitting governance and tech, with automatic move of needed files

## [0.10.1+20220607]

### Fixed

- Fix memory issue by removing unused outputs

## [0.10.0+20220603]

### Added

- [TERGI-64](https://jira-neu.elga.gv.at/browse/TERGI-64) Add `.2.outdatedcsv.xml` and `.2.svsextelga.xml` both of which will provide all concept properties.

## [0.9.2+20220516]

### Fixed

- [TERGI-81](https://jira-neu.elga.gv.at/browse/TERGI-81) Fix using whole url for references to codesystems

## [0.9.1+20220504]

### Changed

- [CSD-1901](https://jira-neu.elga.gv.at/browse/CSD-1901) For `.1.svsextelga.xml` and for `.1.outdatedcsv.csv` it has been highlighted that these formats are deprecated.

## [0.9.0+20220503]

### Changed

- Prevent `output/*.zip`, `output/*.tgz`, `output/*.xlsx`, and `output/*.pack` from being pushed to the HTML project as that would bloat the repository unnecessarily.

## [0.8.1+20220503]

### Fixed

- Clone HTML project in `update_html_project` job as it is not possible to pass it on as artifacts (size limit in GitLab.com is 1G [https://docs.gitlab.com/ee/user/gitlab_com/index.html#gitlab-cicd](https://docs.gitlab.com/ee/user/gitlab_com/index.html#gitlab-cicd)).

## [0.8.0+20220503]

### Changed

- Provide separate job for updating HTML project.

## [0.7.2+20220422]

### Changed

- Improve performance by cloning termgit-html-project only once.

## [0.7.1+20220421]

### Fixed

- Copy "Zuppl" terminologies output directory in order to preserver functionality of versioned files.

## [0.7.0+20220420]

### Changed

- Remove obsolete MaLaC-CT CLI parameters.

## [0.6.1+20220411]

### Fixed

- Rules for creating `robots.txt`.
- Change contact for IG.

## [0.6.0+20220408]

### Added

- Add english pages (`index_en.md`, `faq_en.md`).

## [0.5.2+20220318]

### Fixed

- Touch `processedTerminologies.csv` after execution of MaLaC-CT because MaLaC-CT creates column headers only if file does not exist.

## [0.5.1+20220317]

### Fixed

- Create empty `processedTerminologies.csv` if no terminologies have been processed by MaLaC-CT.

## [0.5.0+20220315]

### Added

- [TERGI-12](https://jira-neu.elga.gv.at/browse/TERGI-12) Support legacy file formats.
- [TERGI-18](https://jira-neu.elga.gv.at/browse/TERGI-18) Create Git tags for OIDs of terminologies.
- Add job `skip_malac-ct` allowing to skip execution of MaLaC-CT.

### Changed

- Convert all CodeSystems before any ValueSet is processed by MaLaC-CT.

## [0.4.0+20220301]

### Added

- Log version of [elgagmbh/fsh-ing-grounds](https://hub.docker.com/r/elgagmbh/fsh-ing-grounds) in pipeline.

### Changed

- Due to a new version of [elgagmbh/fsh-ing-grounds](https://hub.docker.com/r/elgagmbh/fsh-ing-grounds) some of the additional installations of dependencies are no longer necessary. They are provided within the docker image.

## [0.3.0+20220223]

### Added

- Add pipeline job `run_malac-ct_integration_test` for enabling full integration test.

### Changed

- Explicitly state expiry period for artifacts.
- Refactor pipeline and related scripts.

## Fixed

- Make sure `input/includes` directory exists.

## [0.2.0+20220218]

### Added

- [TERGI-3](https://jira-neu.elga.gv.at/browse/TERGI-3) Filter certain files from being included into `sitemap.xml`.

### Fixed

- [TERGI-50](https://jira-neu.elga.gv.at/browse/TERGI-50) Correct versioning of files.

## [0.1.0+20220215]

### Added

- Create `*-download.xhtml` and `*-previous-versions.xhtml` for zuppl-files automatically.
- Add specification of pages to `sushi-config.yaml`.
- Support different converting priorities based on resource type (e.g. CodeSystem).
- Create `sitemap.xml` and `robots.txt` automatically.
- Make upload of terminologies by MaLaC-CT to FHIR server configurable.

### Changed

- Update title of IG.
- Move specification of menu from `menu.xml` to `sushi-config.yaml`.
- Make pipeline repository independent.

### Fixed

- Detect newly created zuppl-files correctly.
- Add check for changed resource type (e.g. CodeSystem).
- Create separate log files for extensive commands.
- Keep download links in versioned files unchanged.
- Keep "Defining URL" within versioned files unchanged.
- Set Xmx to 12g for execution of IG publisher in order to have enough non-heap memory.
- Set default expiry period of artifacts to 1 week.
- Create tags for non-zuppl-terminologies only.

## [0.0.1+20220101]

- Start of parallel operation of TerminoloGit **[https://termgit.elga.gv.at/](https://termgit.elga.gv.at/)** and [https://termpub.gesundheit.gv.at/TermBrowser/gui/main/main.zul](https://termpub.gesundheit.gv.at/TermBrowser/gui/main/main.zul)

