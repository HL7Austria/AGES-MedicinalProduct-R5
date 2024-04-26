# TerminoloGit Template

This IG template is used to display further information regarding Code Systems and Value Sets. The template is based on [HL7 Austria's IG template](https://github.com/gabriel0316/hl7at_template).

For Code Systems and Value Sets the following tabs will be displayed:
- "Narrative Content"
- "Download"
- "Previous Versions"

## Getting Started

Follow these instructions for using this template in your IG.

### Prerequisites

In order to use the template you have to
- have set up an IG Publisher project - see [https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) for more details.
- have set up a CI/CD pipeline which runs https://gitlab.com/elga-gmbh/igver before the IG publisher. Thus, it will be guaranteed that the download and previous version section will be generated accordingly.

### Installing

Use this template by cloning this repository into a local directory and configuring IG's `ig.ini` as follows:

```
[IG]
template = <path_to_directory>/terminologit-template
```

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://gitlab.com/elga-gmbh/terminologit-template/-/tags).

## Authors

* **Gabriel Kleinoscheg** - *Initial work*

