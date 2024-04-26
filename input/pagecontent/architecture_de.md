> **For the english version please click [here](architecture_en.md).**

Zum besseren Verständnis der Architektur von TerminoloGit werden Grundkenntnisse in den folgenden Technologien und/oder Systemen vorausgesetzt:
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

### TerminoloGit und seine Komponenten

TerminoloGit ist ein Open Source Projekt, das aus mehreren interagierenden Repositories besteht und von der österreichischen ELGA GmbH initiiert wurde.

- [TerminoloGit Dev](https://gitlab.com/elga-gmbh/termgit-dev)
- [TerminoloGit Dev HTML](https://gitlab.com/elga-gmbh/terminologit-dev-html) - Hostet statische HTML-Seiten, die die Versionierung von Terminologien ermöglichen.
- [MaLaC-CT (auch Standalone)](https://gitlab.com/elga-gmbh/malac-ct) - Konvertiert zwischen unterstützten [Dateiformaten](file_formats_de.md).
- [TerminoloGit Template](https://gitlab.com/elga-gmbh/terminologit-template) - Formatiert statische HTML-Seiten.
- [fsh-ing-grounds](https://gitlab.com/elga-gmbh/docker/fsh-ing-grounds) oder [docker image elgagmbh/fsh-ing-grounds](https://hub.docker.com/r/elgagmbh/fsh-ing-grounds) - Docker-Image, das für die Ausführung des [HL7® FHIR® IG Publisher](https://github.com/HL7/fhir-ig-publisher) vorbereitet ist
- _external_ [HL7® FHIR® IG Publisher](https://github.com/HL7/fhir-ig-publisher) - Wird verwendet, um statische HTML-Seiten zu erzeugen.

#### TerminoloGit und FHIR® Server

Soll TerminoloGit in Verbindung mit einem FHIR® Server eingesetzt werden, so bietet sich das Projekt [TerminoloGit tergi](https://gitlab.com/elga-gmbh/terminologit-tergi) an, das die Einrichtung eines vollwertigen FHIR® Servers ergänzt durch ein leichtgewichtiges Git Repository ermöglicht.

### Struktur des Repositorys

In diesem Kapitel wird kurz die Struktur eines TerminoloGit-Repositorys erläutert:
- `.` - enthält die `README`, den `CODE_OF_CONDUCT`, das `CONTRIBUTING`, das `CHANGELOG`, die `LICENSE`, sowie eine Menge Skripte, die während eines Pipeline-Laufs verwendet werden.
- `input/files/` - enthält einige Vorlagen, die für die Erstellung von Terminologie verwendet werden.
- `input/fsh/` - wird beibehalten, um TerminoloGit-Benutzern mitzuteilen, dass keine `fsh`-Dateien in diesem Verzeichnis abgelegt werden sollen.
- `input/images/` - Bilder, die in der Dokumentation verwendet werden.
- `input/includes/` - für jede Terminologie wird ein Fragment für ihre Downloads und ihre früheren Versionen in diesem Verzeichnis bereitgestellt. Diese Fragmente werden später von der TerminoloGit-Vorlage verarbeitet.
- `input/pagecontent/` - mehrere Markdown-Dateien, die die Dokumentation von TerminoloGit bilden.
- `input/redirects/` - für jede Terminologie existiert eine redirects-Datei, die den Zugriff auf die Terminologien auf der Grundlage ihres kanonischen Namens ermöglicht.
- `input/resources/` - FHIR®-Ressourcen, die nicht von MaLaC-CT verarbeitet werden sollen, werden in diesem Verzeichnis abgelegt, z.B. ConceptMaps oder intensionale ValueSets.
- `input/sitemap/` - Meta-Informationen für Web-Crawler, wo die Sitemap zu finden ist und welche Seiten indiziert werden sollen.
- `terminologies/` - für jede Terminologie existiert ein Verzeichnis (Muster `[CodeSystem | ValueSet]-[id]`). Außerdem enthält es die `terminologiesMetadata.csv`.

Die Datei `terminologies/terminologiesMeta.csv` enthält einige wichtige Meta-Informationen über alle Terminologien, die von TerminoloGit verwaltet werden:
1. `name` - `[CodeSystem | ValueSet]-[id]`
2. `canonical` - `[TERMGIT_CANONICAL]/[CodeSystem | ValueSet]/[id]`
3. `oid` - OID der Terminologie
4. `version` - Version der Terminologie
5. `id` - die `id` der Terminologie
6. `typ` - `[CodeSystem | ValueSet]`.
7. `metadata-change-timestamp` - der Zeitpunkt der letzten Änderung der Terminologie-Metadaten 

### CI/CD-Ablauf

Die CI/CD-Pipeline in TerminoloGit besteht aus mehreren Phasen und den dazugehörigen Jobs und ist wie folgt aufgebaut. Bitte beachten Sie, dass weder alle Phasen noch alle Jobs in jeder Pipeline ausgeführt werden, sondern dass Regeln bestimmen, welche ausgeführt werden.
- Stage `manual_trigger`
  - Job `manual_trigger` - Ein manueller Auslöser zum Starten der Pipeline in anderen braches als dem Standardbranch. Auf dem Standardbranch wird die Pipeline automatisch gestartet, wenn neue Commits erfolgen.
- Stage `check_variables`
  - Job `check_variables` - Überprüft, ob die erforderlichen Umgebungsvariablen gesetzt sind.
- Stage `run_malac-ct` - Abhängig von den Umständen wird einer der folgenden Jobs ausgeführt.
  - Job `run_malac-ct` - Dieser Job erkennt automatisch neue/aktualisierte Terminologien im Verzeichnis `terminologies/` und konvertiert sie mit Hilfe von MaLaC-CT in alle Dateiformate.
  - Job `run_malac-ct_integration_test` - Dieser Job ist nicht Teil der Standard-Pipeline in einem TerminoloGit-Projekt. Er kann aus einem MaLaC-CT-Repository heraus ausgelöst werden und wird dann anstelle des üblichen `run_malac-ct` ausgeführt. Er konvertiert alle vorhandenen Terminologien eines bestimmten TerminoloGit-Repositorys unter Verwendung eines bestimmten Dateiformats als Quelle.
  - Job `skip_malac-ct` - Dieser Job kann ausgelöst werden, wenn ein Commit mit `SKIP_MALAC` vorangestellt wird. Infolgedessen wird keine Terminologie von MaLaC-CT verarbeitet. *Bitte beachten Sie, dass neue Geschäftsversionen/business versions in diesem Fall NICHT erkannt werden.*
- Stage `run_ig`
  - Job `run_ig` - Dieser Job kümmert sich um die Erstellung früherer Versionen (außer für Pipelines, die mit einem `SKIP_MALAC` Commit gestartet wurden) und startet den HL7® FHIR® IG Publisher, der die statischen HTML-Seiten erstellt.
- Stufe `update_html` - Auf dem Standard-Branch wird immer `update_html_full_content` ausgeführt. Auf anderen Branches wird `update_html_with_diff` ausgeführt.
  - Job `update_html_full_content` - Das Ergebnis von `run_ig` wird den `TERMGIT_HTML_PROJECT_DEFAULT_BRANCH` innerhalb des `TERMGIT_HTML_PROJECT` Projektes aktualisieren.
  - Job `update_html_with_diff` - Das Ergebnis von `run_ig` wird in das `TERMGIT_HTML_PROJECT` gepusht. Der Name des Branches ist derselbe wie im TerminoloGit-Projekt.
- Stage `publish` - Die folgenden Jobs laufen parallel.
  - Job `pages` - Aktualisiert die GitLab-Seiten des TerminoloGit-Projekts.
  - Job `upload_input_resources` - Lädt alle Ressourcen im Verzeichnis `input/resources/` auf die angegebenen FHIR®-Server hoch.


Im Folgenden werden die drei häufigsten Abläufe der CI/CD-Pipeline visualisiert. Details finden Sie in der Datei `.gitlab-ci.yml`.

#### Standard Terminologiepflege

[![CI-CD-Standard](input/images/CICD_standard.drawio.png){: style="width: 100%"}](input/images/CICD_standard.drawio.png)

#### Integrationstest

[![CI-CD-integration-test](input/images/CICD_integration_test.drawio.png){: style="width: 100%"}](input/images/CICD_integration_test.drawio.png)

#### SKIP_MALAC

[![CI-CD-skip-malac](input/images/CICD_skip_malac.drawio.png){: style="width: 100%"}](input/images/CICD_skip_malac.drawio.png)

### Fully dressed use case diagram

Das gesamte Konzept wird in einem fully dressed use case diagram dargestellt, unter dem die schriftlichen Anwendungsfälle auf Unterfunktions-/Fischebene zu finden sind. Bitte beachten Sie, dass dieses Diagramm nicht vollständig mit dem Cockburn-Diagramm für fully dressed use case diagram konform ist. Es wurden ein paar Änderungen vorgenommen, um alle benötigten Informationen in einem Diagramm darzustellen.

[![fully dressed use case diagram](input/images/FullyDressedUseCaseDiagramm.drawio.png){: style="width: 100%"}](input/images/FullyDressedUseCaseDiagramm.drawio.png)

**Parameter für alle Use Cases:**

1. **Akteure:**
   - es wird nur zwischen GitLab-Rollen und dem GitLab-Dienst selbst unterschieden, zusätzliche Rollen können pro Governance in jedem Produktionssystem festgelegt werden
1. **Geltungsbereich:**
   - eine Terminologie wie ein Codesystem oder ein Value-Set
1. **Ebene:**
   - Unterfunktion/Fisch

#### \#1 Konto erstellen, authentifizieren und autorisieren

1. **Akteure:**
   - Gast (Mensch)
   - Dienst (Maschine)
1. **Kurzbeschreibung:** Ein Gast benötigt ein GitLab-Konto für spezielle Interaktionen (z. B. das Abonnieren eines Tags einer Terminologie über GitLab) und erstellt eines über GitLab.
1. **Postkonditionen:**
   1. **Minimalgarantien:** keine
   2. **Erfolgsgarantien:**
      - Es wurde ein Benutzerkonto erstellt
2. **Voraussetzungen:**
   - Die für TerminoloGit benötigten GitLab-Projekte wurden erstellt
3. **Auslöser:**
   - Ein Gast möchte eine spezielle Interaktion durchführen
4. **Grundlegender Ablauf:**
   1. Anlegen eines Kontos auf GitLab und ggf. Beantragung individueller Berechtigungen
   2. Anmeldung bei GitLab
5. **Erweiterungen:** keine
6. **Software:**
   - Jeder Browser
7. **Hardware:**
   - Jeder Client mit einem Browser
8.  **Dienste:**
   - GitLab.com oder eigenes GitLab CE Hosting

#### \#2 Abonnement

1. **Akteure:**
   - Dienst (Maschine)
   - Abonnent (Mensch - ein Gast, der einige Terminologien abonniert hat)
1. **Kurzbeschreibung:** Die Abonnenten werden automatisch per E-Mail informiert, weil eine neue oder bearbeitete Terminologiedatei veröffentlicht wurde.
1. **Postkonditionen:**
   1. **Minimalgarantien:** keine
   2. **Erfolgsgarantien:**
      - Ein Teilnehmer wird über eine neue Terminologie informiert
1. **Voraussetzungen:**
   - Ein Gast hat das GitLab-Projekt TerminoloGit abonniert
2. **Auslöser:**
   - Eine Terminologie wurde hinzugefügt oder aktualisiert
3. **Grundlegender Ablauf:**
   1. GitLab sendet die Änderung an alle Abonnenten
4. **Erweiterungen:** keine
5. **Software:**
   - Jedes E-Mail-Programm
6. **Hardware:**
   - Jeder Client mit einem E-Mail-Programm
7. **Dienste:**
   - GitLab zum Versenden der Änderung an die Abonnenten

#### \#3 Verwendung von FHIR® IG und FHIR-tx

1. **Akteure:**
   - Gast (Mensch oder Maschine)
   - Service (Maschine)
1. **Kurzbeschreibung:** Eine Terminologie wie ein Codesystem oder ein Value-Set wird über die GitLab GUI, TerminoloGit GUI, GitLab REST API oder FHIR-tx REST API Schnittstelle abgefragt
1. **Postconditions:**
   1. **Minimalgarantien:** keine
   2. **Erfolgsgarantien:**
      - wenn die gesuchte Terminologie existiert
        - Empfangen einer Terminologie
1. **Voraussetzungen:**
   - Das TerminoloGit GitLab Projekt existiert
   - Die FHIR® IG ist veröffentlicht
   - Die FHIR-tx ist auf dem neuesten Stand
1. **Auslöser:**
   - Eine Terminologie muss abgerufen werden
1. **Grundlegender Ablauf:**
   1. Durch Aufrufen der FHIR® IG-Website erhält ein Gast ein durchsuchbares Format aller Terminologien mit der Möglichkeit, sie in einem beliebigen Format herunterzuladen
   1. Beim Aufruf der GitLab-Website erhält der Gast eine Liste aller Formate aller Terminologien mit der Möglichkeit, sie herunterzuladen
   2. Durch die Verwendung von REST-Operationen für FHIR® ValueSet- oder CodeSystem-Ressourcen werden die Terminologien von einer Maschine abgerufen
   3. Beim Betrieb mit der GitLab REST API werden die Terminologien von einer Maschine abgerufen
2. **Erweiterungen:**
   - Eine Validierung von Konzepten in ValueSet- oder CodeSystem-Ressourcen ist mit `$validate-code` möglich.
   - Ein Hierarchiestatus zwischen zwei Konzepten in einem CodeSystem ist durch `$subsumes` möglich.
   - Eine detaillierte Ansicht eines Konzepts in einem CodeSystem ist mit `$lookup` möglich.
3. **Software:**
   - Ein Browser oder REST-Client
4. **Hardware:**
   - Client zum Durchsuchen oder Senden von REST-Anfragen
5. **Dienste:**
   - GitLab für die Veröffentlichung von Terminologien
   - ein FHIR®-Server für REST-Anfragen

#### \#4 CRUD und Übertragung einer Terminologie an GitLab

1. **Akteure:**
   - Entwickler (Mensch)
   - Dienst (Maschine)
1. **Kurzbeschreibung:** Eine neue Terminologiedatei wird erstellt oder bearbeitet und an das GitLab-Projekt übergeben
1. **Postconditions:**
   1. **Minimalgarantien:**
      - eine Rückmeldung, was bei dem Commit oder Push falsch gelaufen ist
   2. **Erfolgsgarantien:**
      - Die neue, bearbeitete oder als gelöscht gekennzeichnete Terminologiedatei wird im TerminoloGit GitLab Projekt veröffentlicht. Die CI/CD-Pipeline wird automatisch oder manuell angestoßen
1. **Voraussetzungen:**
   - Das TerminoloGit GitLab Projekt existiert
   - Ein lokaler Git-Client und ein Editor sind auf einem Client installiert oder es wird eine WebIDE von GitLab verwendet
1. **Auslöser:**
   - Eine Terminologie muss erstellt oder aktualisiert werden
1. **Grundlegender Ablauf:**
   1. Mit einem Editor (z.B. Notepad++, Visual Studio Code) oder einer WebIDE wird eine Terminologiedatei im lokalen Git-Repository erstellt, aktualisiert oder gelöscht, indem der Status auf retired gesetzt wird.
   1. In Ihrem lokalen Git-Client wird ein neuer Commit erstellt und an das entfernte TerminoloGit-Repository übertragen
1. **Erweiterungen:**
   - Ein Branching neben dem Standardbranch könnte darauf hinweisen, dass eine neue Übergabe zu Test- oder Genehmigungszwecken durchgeführt wird. In diesem Fall ist das CI/CD von GitLab das gleiche wie für den Standardbranch, mit dem einzigen Unterschied, dass das Ergebnis nur auf einer separaten Seite sichtbar ist.
1. **Software:**
   - ein lokaler Git-Client oder ein Browser
   - ein Editor (z. B. Notepad++, Visual Studio Code) oder ein Browser
2. **Hardware:**
   - Client für die Bearbeitung von Textdateien und Git
3. **Dienste:**
   - GitLab für die Veröffentlichung von Terminologien
   
#### \#5 Kontinuierliche Lieferung an FHIR® IG und FHIR-tx

1. **Akteure:**
   - Service (Maschine)
1. **Kurzbeschreibung:** Eine neue oder bearbeitete Terminologiedatei wird von einem Runner vom GitLab-Service in andere Terminologieformate konvertiert
1. **Postconditions:**
   1. **Minimalgarantien:**
      - Es liegt ein CI/CD-Fehler vor
   2. **Erfolgsgarantien:**
      - Es wird von MaLaC-CT konvertiert, vom IGVer versioniert, vom IG Publisher gerendert und auf einer Gitlab-Seite angezeigt
1. **Voraussetzungen:**
   - Das TerminoloGit GitLab CI/CD ist konfiguriert
1. **Auslöser:**
   - Eine Terminologie wurde hinzugefügt oder aktualisiert
1. **Grundlegender Ablauf:**
   1. Ein GitLab-Runner für das CI/CD wird gestartet, weil ein neuer Commit gepusht wurde
   2. der Runner konvertiert die Terminologie in alle anderen Dateiformate
   3. wenn die Konvertierung erfolgreich war, wird der IGVer und anschließend der IG Publisher gestartet
   4. wenn der IG Publisher bestanden hat, wird der Upload zu FHIR-tx gestartet
2. **Erweiterungen:** keine
3. **Software:** keine
4. **Hardware:** keine
5. **Dienste:**
    * GitLab für die Ausführung des Läufers

#### \#6 In Branches schieben, genehmigen und in Master zusammenführen

1. **Akteure:**
   - Entwickler (Mensch)
   - Dienst (Maschine)
1. **Kurzbeschreibung:** Neue oder bearbeitete Terminologiedateien werden in einen Branch übertragen und für eine Zusammenführung mit Master angefordert.
1. **Postconditions:**
   1. **Minimalgarantien:**
      - Wenn eine Korrektur erforderlich ist:
        - Warten, dass der Entwickler mit einem neuen Commit korrigiert
   2. **Erfolgsgarantien:**
      - ein Branch wurde nach Master zusammengeführt
1. **Voraussetzungen:**
   - Das TerminoloGit-Projekt ist für das Branching konfiguriert
1. **Auslöser:**
   - Eine Terminologie wurde zu einem Branch hinzugefügt oder aktualisiert
1. **Grundlegender Ablauf:**
   1. der Entwickler erstellt einen Branch für seine Commits
   1. der Entwickler erstellt einen Commit mit seinen Änderungen
   1. der Entwickler beantragt eine Zusammenführung mit dem Master oder einem anderen geschützten Branch
   1. ein anderer Entwickler kommentiert die Anfrage und verlangt Änderungen oder akzeptiert diesen Branch
   1. der Entwickler führt ihn mit dem Master zusammen
1. **Erweiterungen:** keine
1. **Software:**
   - ein Browser
1. **Hardware:**
   - eine Maschine mit einem Browser
1. **Dienste:**
   - GitLab zum Ausführen des Läufers

#### BigPicture

Das folgende BigPicture zeigt die verschiedenen Möglichkeiten der Verwendung von TerminoloGit, einschließlich der möglichen kaskadierenden Systemabhängigkeiten.

[![big-picture](input/images/BigPicture.drawio.png){: style="width: 100%"}](input/images/BigPicture.drawio.png)

Die kaskadierende Synchronisierung zwischen TerminoloGit-Instanzen wird durch Merge Requests empfohlen. Sie können Merge Requests zu und von jedem geforketen Projekt erstellen, Sie können sogar [nachträglich Fork-Relationen hinzufügen](https://docs.gitlab.com/ee/api/projects.html#create-a-forked-fromto-relation-between-existing-projects). Beachten Sie, dass Sie bei Fehlern während des Posts (z. B. einem internen Serverfehler von 500) die alte Fork-Relation vorher [löschen](https://docs.gitlab.com/ee/api/projects.html#delete-an-existing-forked-from-relationship) müssen.
Sie können auch die Git-Funktion Submodule oder Subtree verwenden.
Darüber hinaus ist es möglich, die Synchronisation über CI/CD im eigenen System oder über "Mirroring"- oder "Sync"-Funktionen zu automatisieren, wenn Sie selbst keine Anpassungen/Erweiterungen an den Terminologien vornehmen.

Die kaskadierende Synchronisation zwischen einer TerminoloGit-Instanz und einer tergi-Instanz muss in Ihrer TerminoloGit-Instanz eingerichtet werden, siehe [das README im tergi-Repo](https://gitlab.com/elga-gmbh/terminologit-tergi) für weitere Informationen.
