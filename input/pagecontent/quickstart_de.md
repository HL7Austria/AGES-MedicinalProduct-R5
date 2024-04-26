> **For the english version please click [here](quickstart_en.md).**

Mit der folgenden Anleitung können Sie schnell Ihr eigenes TerminoloGit auf der Basis von GitLab.com einrichten.

### Voraussetzungen

- GitLab.com-Benutzerkonto.
  - **Hinweis:** Da Ihr Benutzername als Teil eines CI/CD-Variablenschlüssels verwendet wird, muss er die [Anforderungen für CI/CD-Variablen](https://docs.gitlab.com/ee/ci/variables/#for-a-project) erfüllen, d.h. er muss einzeilig sein, ohne Leerzeichen und darf nur Buchstaben, Zahlen oder `_` enthalten.
  - **Hinweis:** Bei der Erstellung eines neuen Benutzerkontos kann es vorkommen, dass Sie [eine Kredit- oder Debitkartenvalidierung durchführen müssen, um gemeinsam genutzte Runner auf GitLab.com zu nutzen](https://about.gitlab.com/blog/2021/05/17/prevent-crypto-mining-abuse/). Falls erforderlich, werden die entsprechenden Informationen angezeigt, sobald Sie versuchen, Ihre erste Pipeline zu starten.

### Einrichtung

1. Erstellen Sie einen **privaten** Fork von
   - https://gitlab.com/elga-gmbh/termgit-dev
   - https://gitlab.com/elga-gmbh/terminologit-dev-html
   - Wenn Sie alle im österreichischen e-Health Terminologie-Browser veröffentlichten Terminologien benötigen, erstellen Sie einen Fork von https://gitlab.com/elga-gmbh/termgit und https://gitlab.com/elga-gmbh/termgit-html (aufgrund der Größe der Terminologien funktioniert dies nur mit [selbst gehosteten 32GB Runnern](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html)!
1. Konfigurieren Ihres `terminologit-dev-html` Projekts
   1. Erweitern Sie die [inbound job token scope allowlist](https://docs.gitlab.com/ee/ci/jobs/ci_job_token.html#add-a-project-to-the-inbound-job-token-scope-allowlist)
      1. Gehen Sie zu **Settings > CI/CD** und erweitern Sie den Abschnitt **Token Access**.
      2. Fügen Sie unter **Allow CI job tokens from the following projects to access this project**, `[Benutzername]/termgit-dev` zur Liste hinzu.
2. Konfiguration für Ihr `termgit-dev`-Projekt
   1. Erstellen/Konfigurieren Sie die folgenden CI/CD-Variablen als Mindestanforderung unter **Settings > CI/CD** Ihres Termgit-dev-Projekts und erweitern Sie den Abschnitt **Variables**. Die vollständige [Liste der konfigurierbaren CI/CD-Variablen](setup_de.md#cicd-variablen) finden Sie in der Dokumentation.

        | Schlüssel | Wert | Typ | Umgebungsbereich | Variable schützen | Variable maskieren | Variablenreferenz erweitern |
        | --- | --- | --- | --- | --- | --- | --- |
        | `[username]_GITLAB_CI_TOKEN` <br/><br/> Verwenden Sie Ihren GitLab.com-Benutzernamen als Teil des Namens der CI/CD-Variable. | Erstellen Sie ein [personal access token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token) mit den Bereichen `api` und `read_user`.| `Variable` | `Alle` | nein | **ja** | nein |
        | `RUNNER_TAG` | Abhängig von Ihrem GitLab.com-Abo können Sie zwischen den folgenden [SaaS-Runner auf Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html) wählen, z. B. `saas-linux-medium-amd64`. | `Variable` | `Alle` | nein | nein | nein |
        | `RUNNER_TAG_FOR_IG_RUN` | Wird nur für den Job `run_ig` verwendet. Abhängig von Ihrem GitLab.com-Abo können Sie zwischen den folgenden [SaaS-Runner auf Linux](https://docs.gitlab.com/ee/ci/runners/saas/linux_saas_runner.html) wählen, z. B. `saas-linux-medium-amd64`. | `Variable` | `Alle` | nein | nein | nein |
        | `TERMGIT_CANONICAL` | `https://[username].gitlab.io/termgit-dev` | `Variable` | `Alle` | nein | nein | nein |
        | `TERMGIT_HTML_PROJECT` | `[username]/terminologit-dev-html` | `Variable` | `Alle` | nein | nein | nein |
        | `TERMGIT_HTML_PROJECT_DEFAULT_BRANCH` | `master` | `Variable` | `Alle` | nein | nein | nein |
   2. Erstellen Sie die erste Veröffentlichung, indem Sie eine Pipeline manuell ausführen und so einen Git-Commit simulieren.
      1. Gehen Sie zu **CI/CD**, dann **Pipelines**, und klicken Sie auf **Run pipeline**.
      2. Fügen Sie eine CI/CD-Variable namens `CI_COMMIT_TITLE` mit einem beliebigen Wert hinzu, z. B. `test`.
      3. Klicken Sie auf **Run pipeline**.
      4. Beobachten Sie Ihren Pipeline-Run und genießen Sie Ihr erstes veröffentlichtes TerminoloGit unter `https://[username].gitlab.io/termgit-dev` oder `https://[username].gitlab.io/terminologit-dev-html`.

      Weitere Informationen zu allen unterstützten CI/CD-Variablen finden Sie in der [setup](setup_de.md).