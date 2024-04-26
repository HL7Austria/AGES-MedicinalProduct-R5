> **Für die deutsche Version bitte [hier](technical_documentation_de.md) klicken.**

### TerminoloGit

TerminoloGit allows to create, edit, and publish terminologies. This includes code systems, value sets as well as concept maps.

Here you can find the technical documentation about TerminoloGit which comprises the following parts:
- [Architecture](architecture_en.md)
- [Setup](setup_en.md)
- [How to use](use_cases_en.md)
- [File formats](file_formats_en.md)
- [UI features](ui_features_en.md)

### Current state of development

The following two repositories serve to further develop TerminoloGit.

| Project Name | Repository URL | Description | GitLab Project ID | GitLab Pages URL |
| --- | --- | --- | --- | --- |
| TerminoloGit Dev | [https://gitlab.com/elga-gmbh/termgit-dev](https://gitlab.com/elga-gmbh/termgit-dev) | Repository for TerminoloGit technical development.<br/><br/>*Note:* The contents of the last successful pipeline of any Git branch of this repository are displayed under the specified GitLab Pages URL. | 21743825 | [https://elga-gmbh.gitlab.io/termgit-dev/](https://elga-gmbh.gitlab.io/termgit-dev/) |
| TerminoloGit Dev HTML | [https://gitlab.com/elga-gmbh/terminologit-dev-html](https://gitlab.com/elga-gmbh/terminologit-dev-html) | Repository for the static HTML pages created by the HL7® FHIR® IG Publisher based on the `master` branch of [https://gitlab.com/elga-gmbh/termgit-dev](https://gitlab.com/elga-gmbh/termgit-dev). | 28239847 | [https://dev.termgit.elga.gv.at](https://dev.termgit.elga.gv.at) |

### Contributing

Thanks for your interest in contributing! In the spirit of the open source idea, the developers would be very happy about a reference to TerminoloGit, the use of this project or subprojects and even more about active participation. There are many ways to contribute to TerminoloGit. Get started with the [CONTRIBUTING.md in our Dev-Repo](https://gitlab.com/elga-gmbh/termgit-dev/-/blob/stable/CONTRIBUTING.md).

### Reference Implementations

#### Austrian e-Health Terminology Server

The first productive implementation of TerminoloGit was the Austrian e-Health terminology server which uses a variety of different terminologies with different structures from different international, national and local sources. This server was set into production in January 2022 and is actively used within the Austrian e-Health domain, especially the Austrian EHR (ELGA - Elektronische Gesundheitsakte). The current terminologies and governance can be found at [termgit.elga.gv.at](https://termgit.elga.gv.at).

### License and Legal Terms

TerminoloGit is licensed under the GNU General Public License v3.0 or later - see the [LICENSE.md](https://gitlab.com/elga-gmbh/termgit-dev/-/blob/stable/LICENSE.md) file for details.

#### HL7®

HL7®, HEALTH LEVEL SEVEN® and FHIR® are trademarks owned by Health Level Seven International, registered with the United States Patent and Trademark Office.

This Implementation Guide contains and references intellectual property owned by third parties (“Third Party IP”). Acceptance of these License Terms does not grant any rights with respect to Third Party IP. The licensee alone is responsible for identifying and obtaining any necessary licenses or authorizations to utilize Third Party IP in connection with the specification or otherwise.