# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- elga-gmbh/terminologit-template!23 Comment include of previous version links. In order to prevent countless link-errors in the QA of the IG publisher the links to the previous versions will be included as comment. As soon as the IG publisher has finished these comments will be removed, hence, activating the links.

## [1.5.5+20240425]

### Fixed

- Fix broken usage of feedback form (see https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/.E2.9C.94.20Could.20not.20locate.20the.20included.20file.20fragment-feedback_form).

## [1.5.4+20240206]

### Fixed

- elga-gmbh/terminologit-template!21 Fix usage of opened/closed tags.

## [1.5.3+20231113]

### Fixed

- Process files (e.g. code system template).

## [1.5.2+20231003]

### Fixed

- #3 Parse concepts to be expanded/collapsed properly.

## [1.5.1+20230904]

### Fixed

- Prevent a empty first row in all CLDs
- Fix reducing (minus button) a parent element fully that has been expanded (plus button) with its children before

## [1.5.0+20230809]

### Changed

- Prevent `*-testing.html` and `*.change.history.html` from being created.

## [1.4.2+20230725]

### Changed

- elga-gmbh/termgit-dev#39 Remove whole pre-process section to reuse config of base (https://github.com/HL7/ig-template-base/blob/master/config.json)

## [1.4.1+20230420]

### Fixed

- elga-gmbh/terminologit-template#2 Fix visualization of hierarchical ValueSets. 2nd+ child elements were missing in tables with collapsible function.


## [1.4.0+20230303]

### Removed

- Remove tab "Onepage Narrative Content" in order to reduce storage size.

## [1.3.0+20230213]

### Added

- [TERGI-134](https://jira-neu.elga.gv.at/browse/TERGI-134) If there are more than 5 properties specified within a CodeSystem they are collapsed by default.
- [CSD-2493](https://jira-neu.elga.gv.at/browse/CSD-2493) The top level concepts within the expansion of hierarchical ValueSets are collapsed by default. Each level can be expanded manually.
- The content logical definition (CLD) within ValueSets is collapsed by default.
- Tables may be adjusted in their size manually.

### Fixed

- [TERGI-139](https://jira-neu.elga.gv.at/browse/TERGI-139) Enable clusterizing and search functionality for separate designations table.

## [1.2.0+20221114]

### Added

- [TERGI-3](https://jira-neu.elga.gv.at/browse/TERGI-3) Enable searching within terminologies.

### Fixed

- [TERGI-108](https://jira-neu.elga.gv.at/browse/TERGI-108) Support display of large terminologies by clusterized tables.

## [1.1.0+20220930]

### Changed

- Update package ID of base template.

## 1.0.0+20220613

- Publication of template

[1.1.0+20220930]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.0.0+20220613...1.1.0+20220930
[1.2.0+20221114]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.1.0+20220930...1.2.0+20221114
[1.3.0+20230213]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.2.0+20221114...1.3.0+20230213
[1.4.0+20230303]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.3.0+20230213...1.4.0+20230303
[1.4.1+20230420]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.4.0+20230303...1.4.1+20230420
[1.4.2+20230725]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.4.1+20230420...1.4.2+20230725
[1.5.0+20230809]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.4.2+20230725...1.5.0+20230809
[1.5.1+20230904]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.5.0+20230809...1.5.1+20230904
[1.5.2+20231003]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.5.1+20230904...1.5.2+20231003
[1.5.3+20231113]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.5.2+20231003...1.5.3+20231113
[1.5.4+20240206]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.5.3+20231113...1.5.4+20240206
[1.5.5+20240425]: https://gitlab.com/elga-gmbh/terminologit-template/-/compare/1.5.4+20240206...1.5.5+20240425