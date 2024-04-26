> **Für die deutsche Version bitte [hier](ui_features_de.md) klicken.**

### UI features

The [TerminoloGit Template](https://gitlab.com/elga-gmbh/terminologit-template) defines the look and feel of TerminoloGit and comes with the following special features for CodeSystem and ValueSet resources:
- Searchable narrative content
- Download page
- Previous versions of a single terminology

#### Searchable narrative content

The searchable narrative content for terminologies is an optimized view in order to easily search and find concepts within CodeSystems and ValueSets. Furthermore, for a CodeSystem the list of properties will be collapsed by default if it defines more than 5 properties. For ValueSets the content logical definition (CLD) is collapsed by default.

#### Download page

The download page offers the possibility to retrieve the terminology in [all supported file formats](file_formats_en.md).

> Note, that for intensional ValueSets only FHIR® XML or FHIR® JSON is supported currently.

#### Previous version of a single terminology

Old versions of a terminology can be accessed via the "Previous Versions" tab. The table shown contains the following columns:

- `Version Number`: This column contains the version number of the respective version of the terminology.
- `Current Version vs. Outdated Version`: By means of the [W3C HTML Diff Tool](https://services.w3.org/htmldiff) the differences between the old and current version of the terminology can be displayed.

If there are no old versions for a terminology, the table is empty.

In the display an old version is recognizable by a red banner on top of the page. This banner can also be used to switch directly to the current version.