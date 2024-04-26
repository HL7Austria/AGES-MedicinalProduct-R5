> **For the english version please click [here](setup_en.md).**

### Quickstart

Bitte lesen Sie den [Quickstart](quickstart_de.md), um Ihr eigenes TerminoloGit einzurichten.

### TerminoloGit zurücksetzen

Wenn Sie mit TerminoloGit neu anfangen wollen, ist es ratsam, alle terminologiebezogenen Informationen aus dem geforketen Projekt zu löschen.

Lesen Sie die Beschreibung über das [Löschen einer Terminologie](use_cases_de.md#löschen-einer-terminologie), um Ihren TerminoloGit Fork zurückzusetzen.

### Landing Page hinzufügen

TerminoloGit erwartet die folgenden Dateien:

- `input/pagecontent/index.md`
- `input/pagecontent/index_en.md`

Die primäre Sprache ist `de`, daher sollte `index.md` die deutsche Version der Landing Page enthalten. Auf der anderen Seite sollte `index_en.md` die englische Version der Landing Page enthalten.

> Falls eine oder beide Dateien nicht angegeben werden, enthalten sie automatisch den Inhalt von `technical_documentation_de.md` und `technical_documentation_en.md`.

### CI/CD-Variablen

In der folgenden Tabelle sind alle CI/CD-Variablen aufgeführt, die zur Konfiguration der Funktionalität von TerminoloGit verwendet werden können. Abgesehen von den Spalten `Beschreibung` und `Erforderlich` stellen die Spalten die Felder dar, die bei der Erstellung einer [CI/CD-Variable in GitLab](https://docs.gitlab.com/ee/ci/variables/) ausgefüllt werden müssen.

| Schlüssel | Beschreibung | Erforderlich | Wert (Beispiel) | Typ | Umgebung | Variable schützen | Variable maskieren | Variablenreferenz erweitern |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `[username]_GITLAB_CI_TOKEN` <br/><br/> Verwenden Sie Ihren GitLab.com-Benutzernamen als Teil des Namens der CI/CD-Variable. | Ermöglicht es, bestimmte in den Pipelines erstellte Ergebnisse in das Repository zu pushen. | **ja** | Erstellen Sie einen [persönlichen Zugriffstoken](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token) mit den Geltungsbereichen `api` und `read_user` | `Variable` | `Alle` | nein | **ja** | nein |
| `RUNNER_TAG` | Gibt an, welcher SaaS-Runner von GitLab.com von den Pipeline-Aufträgen verwendet werden soll. | **ja** | Abhängig von Ihrem GitLab.com-Abo können Sie zwischen den folgenden [SaaS-Runner auf Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html) wählen, z.B. `saas-linux-medium-amd64`. | `Variable` | `Alle` | nein | nein | nein |
| `RUNNER_TAG_FOR_IG_RUN` | Wird nur für den `run_ig` Job verwendet. Gibt an, welcher SaaS-Runner von GitLab.com von den Pipeline-Aufträgen verwendet werden soll. | **ja** | Abhängig von Ihrem GitLab.com-Abo können Sie zwischen den folgenden [SaaS-Runner auf Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html) wählen, z.B. `saas-linux-medium-amd64`. | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_CANONICAL` | Gibt die kanonische URL für das erstellte FHIR® IG an und wird als Basis-URL für diejenigen Terminologien verwendet, die noch keine eigene kanonische URL angegeben haben. | **ja** | `https://[username].gitlab.io/termgit-dev` | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_HTML_PROJECT` | GitLab-Projektpfad zum TerminoloGit-HTML-Projekt, das die vom HL7® FHIR® IG-Publisher erzeugten statischen HTML-Seiten hosten soll. | **ja** | `[username]/terminologit-dev-html` | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_HTML_PROJECT_DEFAULT_BRANCH` | Default-Branch des TerminoloGit HTML-Projekts. | **ja** | `main` | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_BOT_CI_TOKEN` | [Persönlicher Zugriffstoken](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token) eines Fallback-GitLab-Benutzerkontos, das Push-Vorgänge ausführen darf, falls der Benutzer, der die Pipeline ausführt, nicht über die erforderlichen Berechtigungen verfügt. Dies ist im Falle von externen Terminologieanbietern praktisch. | nein | `das-ist-ein-beispiel-token` | `Variable` | `Alle` | nein | **ja** | nein |
| `TERMGIT_BOT_USER_NAME` | GitLab-Benutzername des Fallback-Benutzers. | Ja, wenn `TERMGIT_BOT_CI_TOKEN` verwendet wird. | `bot-name` | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_BOT_EMAIL` | E-Mail des Fallback-Benutzers. | Ja, wenn `TERMGIT_BOT_CI_TOKEN` verwendet wird. | `bot@email.com` | `Variable` | `Alle` | nein | nein | nein |
| `IG_PUBLISHER_URL` | Verwenden Sie dies, um eine bestimmte Version des [HL7® FHIR® IG Publisher](https://github.com/HL7/fhir-ig-publisher) zu verwenden. Wenn diese Variable nicht gesetzt ist, wird der IG-Publisher verwendet, der mit dem [Docker-Image elgagmbh/fsh-ing-grounds](https://hub.docker.com/r/elgagmbh/fsh-ing-grounds) ausgeliefert wird. | nein | aktuelle Version: `https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar`<br/>bestimmte Version: `https://github.com/HL7/fhir-ig-publisher/releases/download/1.3.28/publisher.jar` | `Variable` | `Alle` | nein | nein | nein |
| `GITLAB_CI_TOKEN` | Wird von `create_gitlab_ci_token.sh` erstellt und enthält das Token, das für den Push an andere GitLab-Repositories verwendet wird. | *automatisch erstellt* | `ein_CI_token` | `Variable` | `Alle` | nein | nein | nein |
| `GITLAB_USER_OR_TERMGIT_BOT_EMAIL` | Wird von `create_gitlab_ci_token.sh` erstellt und enthält die E-Mail-Adresse, die zur Konfiguration von Git innerhalb eines Jobs verwendet wird. | *automatisch erstellt* | `eine@email.com` | `Variable` | `Alle` | nein | nein | nein |
| `GITLAB_USER_OR_TERMGIT_BOT_NAME` | Wird von `create_gitlab_ci_token.sh` erstellt und enthält den Benutzernamen, der für die Konfiguration von Git innerhalb eines Jobs verwendet wird. | *automatisch erstellt* | `ein_benutzername` | `Variable` | `Alle` | nein | nein | nein |
| `CI_DO_FULL_IGPUB_CREATION_IN_BRANCH` | Standardmäßig werden alle Terminologien nur im Default-Branch vom IG-Publisher bearbeitet. Wenn diese Variable auf einen beliebigen Wert gesetzt wird, werden alle Terminologien vom IG-Publisher in allen Branches bearbeitet. | nein | `true` | `Variable` | `Alle` | nein | nein | nein |
| `TURN_OFF_VERIFICATION_IN_REST_CALLS` | Wenn auf `true` gesetzt, wird keine Zertifikatsüberprüfung durchgeführt. | nein | `false` | `Variable` | `Alle` | nein | nein | nein |
| `IG_PUB_TEMPLATE_URL` | URL des Repositorys, in dem das zu verwendende Template für den IG-Publisher gespeichert ist. Wird nichts angegeben, wird `https://gitlab.com/elga-gmbh/terminologit-template.git` verwendet. | nein | `https://github.com/HL7/ig-template-base.git` | `Variable` | `Alle` | nein | nein | nein |
| `IG_PUB_TEMPLATE_BRANCH` | Branch des Template-Repositorys (siehe `IG_PUB_TEMPLATE_URL`), der für den IG-Publisher verwendet werden soll. Wird nichts angegeben, so wird der jeweilige Default-Branch verwendet. | nein | `dev` | `Variable` | `Alle` | nein | nein | nein |
| `JAVA_OPTS` | Ermöglicht es, Optionen an den Aufruf von Java für den IG-Publisher zu übergeben. | nein | `-Xms13g -Xmx13g -XX:+UseG1GC` | `Variable` | `Alle` | nein | nein | nein |

Die folgenden [von GitLab vordefinierten CI/CD-Variablen](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html) haben auch Auswirkungen auf TerminoloGit:

| Schlüssel | Beschreibung | Wert (Beispiel) |
| --- | --- | --- |
| `CI_COMMIT_BRANCH` | Name des Commit-Branches. | `dev` |
| `CI_DEFAULT_BRANCH` | Name des Default-Branches des Projekts. | `main` |
| `CI_COMMIT_TITLE` | Die vollständige erste Zeile der Commit-Nachricht, auch bekannt als Commit-Titel. Commit-Nachrichten, die mit `AUTOMATIC_COMMIT` beginnen, sollen keine Pipeline auslösen. Wie eine Pipeline ohne Commit ausgelöst werden kann, erfahren Sie im Kapitel über das [Starten einer Pipeline](use_cases_de.md#eine-pipeline-starten). | `Add terminology` |
| `CI_PIPELINE_SOURCE` | Wie die Pipeline ausgelöst wurde. | `push`, `pipeline`, etc. |
| `CI_JOB_TOKEN` | Ein Token zur Authentifizierung bei bestimmten API-Endpunkten. Das Token ist so lange gültig, wie der Job ausgeführt wird. Wird für das Klonen anderer GitLab-Repositories verwendet. | `ein_CI_token` |
| `GITLAB_USER_LOGIN` | Der Benutzername des Benutzers, der die Pipeline gestartet hat, es sei denn, der Job ist ein manueller Job. Bei manuellen Jobs ist der Wert der Benutzername des Benutzers, der den Job gestartet hat. | `gitlab_user_name` |
| `CI_PROJECT_PATH` | Der Projekt-Namensraum mit dem Projektnamen. | `elga-gmbh/termgit-dev` |

#### Integrationstest

Für Integrationstests werden die folgenden **zusätzlichen** CI/CD-Variablen benötigt:

| Schlüssel | Beschreibung | Erforderlich | Wert (Beispiel) | Typ | Umgebung | Variable schützen | Variable maskieren | Variablenreferenz erweitern |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `MALAC_CT_PROJECT` | GitLab-Projektpfad des MaLaC-CT-Projekts, das für den Integrationstest verwendet werden soll.  | **Ja**, wenn die Pipeline nicht im Rahmen des MaLaC-CT-Projekts gestartet wurde. | `elga-gmbh/malac-ct` | `Variable` | `Alle` | nein | nein | nein |
| `MALAC_CT_PROJECT_BRANCH` | Branch des MaLaC-CT-Projekts, der für den Integrationstest ausgecheckt werden soll. | **Ja**, wenn die Pipeline nicht innerhalb des MaLaC-CT-Projekts gestartet wurde. | `main` | `Variable` | `Alle` | nein | nein | nein |
| `CS_INPUT_FORMAT` | [Dateiformat](file_formats_de.md), das von MaLaC-CT als Quelle für Codesysteme zur Erstellung aller anderen Dateiformate verwendet werden soll. | **Ja**, wenn die Pipeline nicht innerhalb des MaLaC-CT-Projekts gestartet wurde. | `.1.propcsv.xlsx` | `Variable` | `Alle` | nein | nein | nein |
| `VS_INPUT_FORMAT` | [Dateiformat](file_formats_de.md), das von MaLaC-CT als Quelle für Value-Sets zur Erstellung aller anderen Dateiformate verwendet werden soll. | **Ja**, wenn die Pipeline nicht innerhalb des MaLaC-CT-Projekts gestartet wurde. | `.1.propcsv.xlsx` | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_TERMINOLOGIES_PROJECT` | GitLab-Projektpfad des TerminoloGit-Projekts, dessen Terminologien im Integrationstest verwendet werden sollen. | **Ja**, wenn die Pipeline nicht innerhalb des MaLaC-CT-Projekts gestartet wurde. | `elga-gmbh/termgit` | `Variable` | `Alle` | nein | nein | nein |
| `TERMGIT_TERMINOLOGIES_PROJECT_BRANCH` | Branch des TerminoloGit-Projekts, dessen Terminologien im Integrationstest verwendet werden sollen. | **Ja**, wenn die Pipeline nicht innerhalb des MaLaC-CT-Projekts gestartet wurde. | `main` | `Variable` | `Alle` | nein | nein | nein |

Die folgenden [von GitLab vordefinierten CI/CD-Variablen](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html) wirken sich ebenfalls auf den Integrationstest aus:

| Schlüssel | Beschreibung | Wert (Beispiel) |
| --- | --- | --- |
| `CI_PIPELINE_SOURCE` | Wie die Pipeline ausgelöst wurde. | `pipeline` (erforderlich) |
| `CI_JOB_URL` | Die URL der Job-Details. Wird verwendet, um die Download-Seite einer Terminologie zu erstellen. | `https://eine_url` |
