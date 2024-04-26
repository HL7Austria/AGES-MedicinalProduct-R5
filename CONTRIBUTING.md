# Contributing to TerminoloGit

:tada: First off, thanks for taking the time to contribute! :tada:

The following is a set of guidelines for contributing to TerminoloGit and its subprojects, which are hosted in the [ELGA GmbH Organization](https://gitlab.com/elga-gmbh) on GitLab. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a merge request.

#### Table Of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[What should I know before I get started?](#what-should-i-know-before-i-get-started)
  * [TerminoloGit and it's components](#TerminoloGit-and-it's-components)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)
  * [Suggesting Enhancements](#suggesting-enhancements)
  * [Your First Code Contribution](#your-first-code-contribution)
  * [merge requests](#merge-requests)

[Styleguides](#styleguides)
  * [Git Commit Messages](#git-commit-messages)
  * [draw.io diagramms](#draw.io-diagramms)

[Additional Notes](#additional-notes)
  * [Issue and merge request Labels](#issue-and-merge-request-labels)

## Code of Conduct

This project and everyone participating in it is governed by the [TerminoloGit Code of Conduct](CODE_OF_CONDUCT.md). Our Code of Conduct means that you are responsible for treating everyone on the project with respect and courtesy regardless of their identity. By participating, you are expected to uphold this code. Please report unacceptable behavior to [cda@elga.gv.at](mailto:cda@elga.gv.at).

## I don't want to read this whole thing I just have a question!!!

> **Note:** [Please try to strg+f first some keywords of your question in our [README](README.md). There you'll get the fastest results.

We are using GitLab.com issues for questions and will update the README if needed.
For creating an issue, click [here](https://gitlab.com/elga-gmbh/termgit-dev/-/issues/new) and log in with your GitLab.com user.

## What should I know before I get started?

### TerminoloGit and its components

To get started you should look into the [technical documentation](technical_documentation.md) where you'll find how the [components](architechture_en.md#TerminoloGit-and-its-components) are interacting together and how you could easily setup a TerminoloGit.

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for TerminoloGit. Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer: :computer:, and find related reports :mag_right:.

When you are creating a bug report, please [include as many details as possible](#how-do-i-submit-a-good-bug-report).

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### How Do I Submit A (Good) Bug Report?

Bugs are tracked as GitLab issues in the corresponding project, like [here for the main TerminoloGit dev](https://gitlab.com/elga-gmbh/termgit-dev/-/issues). After you've determined [which repository](#TerminoloGit-and-it's-components) your bug is related to, create an issue on that repository, explain the problem, and include additional details to help maintainers reproduce the problem:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible. For example, start by explaining how you setup TerminoloGit, e.g. which CI/CD variables exactly you used, or how you use TerminoloGit otherwise. When listing steps, **don't just say what you did, but explain how you did it**. For example, if you published a new terminology, explain if you used MaLaC-CT in the pipeline, or converted it locally, or just added it to the `input/includes` directory instead of the `terminologies` directory?
* **Provide specific examples to demonstrate the steps**. Include links to files or GitLab projects, or copy/pasteable snippets, which you use in those examples. If you're providing snippets in the issue, use Markdown code blocks.
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **Include screenshots and animated GIFs** which show you following the described steps and clearly demonstrate the problem. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.
* **If you're reporting that a TerminoloGit pipeline crashed**, include the link to the pipeline.
* **If the problem is related to performance or memory**, include all your CI/CD variables.
* **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened and share more information using the guidelines below.

Provide more context by answering these questions:

* **Can you reproduce the problem?**
* **Did the problem start happening recently** (e.g. after updating to a new version of TerminoloGit) or was this always a problem?
* If the problem started happening recently, **can you reproduce the problem in an older version of TerminoloGit?** What's the most recent version in which the problem doesn't happen? You can download older versions of TerminoloGit from [the tags page](https://gitlab.com/elga-gmbh/termgit-dev/-/tags).
* **Can you reliably reproduce the issue?** If not, provide details about how often the problem happens and under which conditions it normally happens.
* If the problem is related to converting terminology files (e.g. some information from the input file is not beeing converted), **does the problem happen for all terminologies or only some?** Does the problem happen only when working with specific formats of terminologies, with large terminologies or terminologies with very complex attributes, or with terminologies in a specific encoding? Is there anything else special about the files you are using?

Include details about your configuration and environment:

* **Which version of TerminoloGit are you using?** You can get the exact version by looking into the changelog or into the tags.
* **Are you using own GitLab Runners for TerminoloGit?** If so, which version of the runner are you using?
* **What browser are you using for browsing the output?** Can you reproduce the behavior with another browser?

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for TerminoloGit, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

When you are creating an enhancement suggestion, please [include as many details as possible](#how-do-i-submit-a-good-enhancement-suggestion).

#### How Do I Submit A (Good) Enhancement Suggestion?

Enhancement suggestions are tracked as GitLab issues in the corresponding project, like [here for the main TerminoloGit dev](https://gitlab.com/elga-gmbh/termgit-dev/-/issues). After you've determined [which repository](#TerminoloGit-and-it's-components) your  enhancement suggestion is related to, create an issue on that repository and provide the following information:

* **Use a clear and descriptive title** for the issue to identify the suggestion.
* **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
* **Provide specific examples to demonstrate the steps**. Include copy/pasteable snippets which you use in those examples.
* **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
* **Include screenshots and animated GIFs** which help you demonstrate the steps or point out the part of TerminoloGit which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.
* **Explain why this enhancement would be useful to most TerminoloGit users.**
* **List some other terminology systems or other applications where this enhancement exists.**
* **Specify which version of TerminoloGit you're using.** You can get the exact version by looking into the changelog or into the tags.

### Your First Code Contribution

Unsure where to begin contributing to TerminoloGit? You can start by looking through these `beginner` and `help-wanted` issues:

* [Beginner issues](https://gitlab.com/elga-gmbh/termgit-dev/-/issues?label_name%5B%5D=richness%3A%3Abeginner) - issues which should only require a few lines of code, and a test or two.
* [Help wanted issues](https://gitlab.com/elga-gmbh/termgit-dev/-/issues?label_name%5B%5D=richness%3A%3Ahelp-wanted) - issues which should be a bit more involved than `beginner` issues.

#### Local development

Many features of TerminoloGit can't be developed locally. It is ok to create a branch and test it online in GitLab.com.

### Merge Requests

The process described here has several goals:

- Maintain TerminoloGit's quality
- Fix problems that are important to users
- Engage the community in working toward the best possible TerminoloGit
- Enable a sustainable system for TerminoloGit's maintainers to review contributions

Please follow these steps to have your contribution considered by the maintainers:

1. Create a new merge request in GitLab.com in the corresponding repository into the `dev` branch! Name the merge request starting with the issue number.
2. After you submit your code to the merge request, verify that the pipeline completes succesfully.
3. Add some labels to your merge request, at least one of `change level::*` in the sense of https://semver.org/.  Don't forget to add your change to the changelog. The version number itself is only set in release merge requests from `dev` to `master`.
4. Assign a or multiple reviewer (minimum one owner or maintainer - see [here](https://gitlab.com/elga-gmbh/termgit-dev/-/project_members)) if you are happy with what you've done.

While the prerequisites above must be satisfied prior to having your merge request reviewed, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your merge request can be ultimately accepted.

## Styleguides

### Git Commit Messages

* Use english
* Limit the first line as subject to 50 characters or less
* If you need to add more information, separate the first line from the body with a blank line an add there some more information, here the maximum characters are 72 for one line
* Use the body to explain what and why vs. how
* Capitalize the subject line
* Do not end the subject line with a period
* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* When adding a bunch of preconverted terminologies and you don't want to run MaLaC-CT in this pipeline, start with `SKIP_MALAC` in the commit title
* Consider starting the commit message with an applicable emoji:
    * :art: `:art:` when improving the format/structure of the code
    * :racehorse: `:racehorse:` when improving performance
    * :non-potable_water: `:non-potable_water:` when plugging memory leaks
    * :memo: `:memo:` when writing docs
    * :penguin: `:penguin:` when fixing something on Linux
    * :apple: `:apple:` when fixing something on macOS
    * :checkered_flag: `:checkered_flag:` when fixing something on Windows
    * :bug: `:bug:` when fixing a bug
    * :fire: `:fire:` when removing code or files
    * :green_heart: `:green_heart:` when fixing the CI build
    * :white_check_mark: `:white_check_mark:` when adding tests
    * :lock: `:lock:` when dealing with security
    * :arrow_up: `:arrow_up:` when upgrading dependencies
    * :arrow_down: `:arrow_down:` when downgrading dependencies

### draw.io diagramms

For creating or altering any diagram, draw.io has to be used, for easily creating and merging the changes via draw.io .

Simply open draw.io, log in with your GitLab.com account, choose the repo with the diagram, choose the branch and create the \*.drawio.xml or open an existing \*.drawio.xml.

As example here one [digram from TerminoloGit](https://app.diagrams.net/#Aelga-gmbh%2Ftermgit-dev%2Fdev%2Finput%2Fimages%2FBigPicture.drawio.png) and [one from MaLaC-CT](https://app.diagrams.net/#Aelga-gmbh%2Fmalac-ct%2Fmaster%2FMaLaC-CT_class_diagram.drawio.xml).

## Issue and merge request Labels

[Here](https://gitlab.com/groups/elga-gmbh/-/labels) you can find all labels we use that help us track and manage issues and merge requests. All labels are used across all TerminoloGit repositories, no own repository/project labels are allowed.

The labels are grouped by their purpose, but it's not required that every issue has a label from every group. However, an issue can't have more than one label from the same group.

Please [open an issue](#suggesting-enhancements) if you have suggestions for new labels.