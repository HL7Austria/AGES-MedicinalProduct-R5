> **For the english version please click [here](use_cases_en.md).**

Eine eher allgemeine Beschreibung der verschiedenen Anwendungsfälle finden Sie hier. Bitte beachten Sie, dass dies keine vollständige Liste von Anwendungsfällen ist. Sie soll Ihnen nur einen Eindruck davon vermitteln, was mit TerminoloGit möglich ist.

### Hinzufügen einer neuen Terminologie

**Codesysteme und extensionale Value-Sets** sollten **[zum Verzeichnis `terminologies/` hinzugefügt werden](#hinzufügen-einer-neuen-terminologie-in-das-verzeichnis-terminologies)**, damit sie von MaLaC-CT in alle unterstützten [Dateiformate](file_formats_de.md) konvertiert werden können.

**Intensionale ValueSets und andere FHIR®-Ressourcen** müssen dagegen **[zum Verzeichnis `input/resources/` hinzugefügt werden](#hinzufügen-intensionaler-valuesets-oder-anderer-fhir-ressourcen-zum-verzeichnis-inputresources)**, da sie von MaLaC-CT nicht unterstützt werden.

Eine zusätzliche Konfiguration von TerminoloGit wird empfohlen, wenn **[das Hinzufügen einer Terminologie mit einer anderen Basis-URL](#hinzufügen-von-terminologien-mit-einer-anderen-basis-url)** innerhalb ihres Canonicals.

#### Hinzufügen einer neuen Terminologie in das Verzeichnis terminologies/

Codesysteme und extensionale Value-Sets sollten dem Verzeichnis `terminologies/` hinzugefügt werden, damit sie von MaLaC-CT in alle anderen unterstützten [Dateiformate](file_formats_de.md) konvertiert werden können.

> Eine neue Terminologie kann in jedem der unterstützten [Dateiformate](file_formats_de.md) erstellt werden. Es wird jedoch nicht empfohlen, eines der veralteten Dateiformate zu verwenden, da dies zu einem Informationsverlust führen kann.

Im Folgenden wird beschrieben, wie Sie eine neue Terminologie auf der Grundlage des Dateiformats `.1.propcsv.xlsx` hinzufügen:
1. Laden Sie die **Vorlagen für ein [Codesystem](input/files/CodeSystem-cs-import-template.1.propcsv.xlsx) oder ein [Value-Set](input/files/ValueSet-vs-import-template.1.propcsv.xlsx)** herunter, um ein neues Codesystem bzw. Value-Set zu erstellen. *Hinweis: Zellen, die bearbeitet werden müssen, sind gelb hervorgehoben.
2. Nach der Bearbeitung der Datei benennen Sie diese nach folgendem Muster um:
   1. `[CodeSystem | ValueSet]-[id].1.propcsv.xlsx`
3. Erstellen Sie einen neuen Branch innerhalb des Repositorys und arbeiten Sie damit weiter.
3. Erstellen Sie ein neues Unterverzeichnis innerhalb von `terminologies/` nach dem folgenden Muster:
   1. `[CodeSystem | ValueSet]-[id]`
4. Legen Sie die Datei `.1.propcsv.xlsx` in das entsprechende Verzeichnis innerhalb des Verzeichnisses `terminologies/`. Der resultierende Pfad sollte wie folgt aussehen:
   1. `terminologies/[CodeSystem | ValueSet]-[id]/[CodeSystem | ValueSet]-[id].1.propcsv.xlsx` z.B. `terminologies/CodeSystem-appc-anatomie/CodeSystem-appc-anatomie.1.propcsv.xlsx` oder `terminologies/ValueSet-elga-laborparameter/ValueSet-elga-laborparameter.1.propcsv.xlsx`.
5. Commit und Push der Änderungen in den neuen Branch.
6. Erstellen Sie eine Merge-Request in GitLab.
7. Starten Sie die Pipeline manuell in GitLab.
8. Überprüfen Sie die Ergebnisse der Pipeline - die folgenden Dateien sollten von der Pipeline automatisch erstellt werden:
   1.  `input/includes/`
       1.  `[CodeSystem | ValueSet]-[id]-download.xhtml`
       2.  `[CodeSystem | ValueSet]-[id]-previous-versions.xhtml`
   2.  `input/redirects/`
       1.  `[CodeSystem | ValueSet]/[id].html`
   3.  `terminologies/[CodeSystem | ValueSet]-[id]/`
       1. alle anderen Dateiformate
9.  Wenn die Pipeline erfolgreich abgelaufen ist und der Merge-Request genehmigt wurde (optional), kann sie in den Standardzweig zusammengeführt werden.
10. Auf dem Standardzweig wird die Pipeline automatisch gestartet.
11. Die neue Terminologie wurde erfolgreich veröffentlicht.

#### Hinzufügen intensionaler ValueSets oder anderer FHIR®-Ressourcen zum Verzeichnis input/resources/

Intensionale ValueSets oder andere FHIR®-Ressourcen (als FHIR® XML oder FHIR® JSON) müssen in das Verzeichnis `input/resources/` aufgenommen werden, da sie von MaLaC-CT nicht konvertiert werden können.

Beachten Sie die folgenden Anforderungen:
- Zusätzliche Dateien, die von der TerminoloGit-Vorlage für intensionale ValueSets benötigt werden, müssen manuell erstellt werden.

Der folgende Prozess beschreibt, wie Sie ein intensionales ValueSet oder andere FHIR®-Ressourcen hinzufügen:
1. Erstellen Sie das intensionale ValueSet oder die FHIR®-Ressource gemäß der FHIR®-Spezifikation und speichern Sie es innerhalb von `input/resources/` nach folgendem Muster:
   1. `[FHIR® resource type]-[id].[xml | json]`
2. Erstellen Sie einen neuen Branch im Repository und arbeiten Sie mit diesem weiter.
2. Für intensionale ValueSets erstellen Sie die folgenden Dateien:
   1. `input/includes/[CodeSystem | ValueSet]-[id]-download.xhtml` unter Verwendung der **[Download-Vorlage](input/files/download-template.xhtml)** durch entsprechendes Ersetzen von `[CI_PROJECT_PATH]`, `[CI_DEFAULT_BRANCH]` und `[CodeSystem | ValueSet]-[id]` sowie unter Verwendung der entsprechenden Dateierweiterung `xml` oder `json`, je nachdem in welchem Format das ValueSet erstellt wurde.
   2. `input/includes/[CodeSystem | ValueSet]-[id]-previous-versions.xhtml` unter Verwendung der **[Vorlage für frühere Versionen](input/files/previous-versions-template.xhtml)**.
   3. `input/redirects/[CodeSystem | ValueSet]/[id].html` unter Verwendung der **<a href="files/redirects-template.html" download="redirects-template">Vorlage für Weiterleitungen</a>** durch entsprechendes Ersetzen von `[TERMGIT_CANONICAL]` und `[CodeSystem | ValueSet]-[id]`.
3. Für CodeSystems und ValueSets eine Zeile in `terminologies/terminologiesMetadata.csv` hinzufügen
   1. `name` - `[CodeSystem | ValueSet]-[id]`.
   2. `canonical` - `[TERMGIT_CANONICAL]/[CodeSystem | ValueSet]/[id]`
   3. `oid` - OID der Terminologie
   4. `version` - Version der Terminologie
   5. `id` - `[id]`
   6. `type` - `[CodeSystem | ValueSet]`.
   7. `metadata-change-timestamp` - der Zeitpunkt der letzten Änderung der Terminologie-Metadaten.
4. Commit und Push der Änderungen in den neuen Branch.
5. Erstellen Sie eine Merge-Request in GitLab.
6. Starten Sie die Pipeline manuell in GitLab.
7. Überprüfen Sie die Ergebnisse der Pipeline.
8. Wenn die Pipeline erfolgreich verlaufen ist und die Merge-Request genehmigt wurde, kann sie in den Standardbranch zusammengeführt werden.
9.  Auf dem Standardbranch wird die Pipeline automatisch gestartet.
10. Das intensional ValueSet oder die FHIR®-Ressource wurde erfolgreich veröffentlicht.

#### Hinzufügen von Terminologien mit einer anderen Basis-URL

Es ist möglich, Terminologien hinzuzufügen, die eine kanonische URL haben, deren Basis nicht mit der `TERMGIT_CANONICAL` übereinstimmt, z.B. die `TERMGIT_CANONICAL` ist `https://termgit.elga.gv.at`, aber die kanonische URL der Terminologie ist `http://terminology.hl7.org/ValueSet/v3-TargetAwareness`.


In einem solchen Fall folgen Sie den Anweisungen wie oben beschrieben, je nachdem, was am besten zu der hinzuzufügenden Ressource passt, aber es wird zusätzlich empfohlen, den Canonical der Ressource in die `sushi-config.yaml` aufzunehmen:


    ...
    Parameter:
      ...
      special-url:
        - http://terminology.hl7.org/ValueSet/v3-TargetAwareness
    ...


### Verweis auf externe Codesysteme


Es ist möglich, dass ein Value-Set auf einem Codesystem basiert, das weder in `terminologies/` noch in `input/resources/` enthalten ist, z.B. `http://loinc.org` oder `http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender`. In einem solchen Fall muss ein manueller Eintrag in der Datei `terminologies/terminologiesMetadata.csv` hinzugefügt werden, um eine Konvertierung der Value-Set in alle Dateiformate zu gewährleisten.

Hinzufügen einer Zeile zu `terminologies/terminologiesMetadata.csv`
   1. `name` - leer
   2. `canonical` - Canonical des referenzierten Codesystems, z.B. `http://loinc.org` oder `http://terminology.hl7.org/CodeSystem/v3-AdministrativeGender`
   3. `oid` - OID der Terminologie
   4. `version` - Version der Terminologie
   5. `id` - leer
   6. `Typ` - leer
   7. `metadata-change-timestamp` - leer

### Terminologie aktualisieren

#### Aktualisieren einer Terminologie im Verzeichnis terminologies/

Es kann einfach jedes der unterstützten [Dateiformate](file_formats_de.md) einer Terminologie im Verzeichnis `terminologies/` bearbeitet und commited werden, um eine aktualisierte Veröffentlichung der Terminologie auszulösen.

Wenn die Geschäftsversion der Terminologie (`CodeSystem.version` bzw. `ValueSet.version`) erhöht wurde, erstellt `IGver.py` automatisch eine vorherige Version für die Terminologie.

#### Aktualisierung einer Terminologie im Verzeichnis input/resources/

Aktualisieren Sie einfach die Terminologie im Verzeichnis `input/resources/`.

Wenn für die aktualisierte Terminologie eine frühere Version erstellt werden soll, muss dies manuell geschehen:
1. Innerhalb des Projekts `TERMGIT_HTML_PROJECT`:
   1. Erstellen Sie eine Kopie der folgenden Dateien, wobei `YYYYMMDD-hhmmss-` das Datum und die Uhrzeit der Erstellung der Kopie darstellt:
      1. `output/[CodeSystem | ValueSet]-[id].html` und erstellen Sie `output/YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].html`.
      2. `output/[CodeSystem | ValueSet]-[id].download.html` und Erstellung von `output/YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].download.html`.
   2. Fügen Sie in den kopierten Dateien das folgende Banner ein und ersetzen Sie `[CodeSystem | ValueSet]-[id]` entsprechend:
      ```
      <div role="alert" class="alert alert-danger">
        <p id="publish-box">This is an outdated version that is no longer valid! You can access the <a href=[CodeSystem | ValueSet]-[id].html>current version here</a>.</p>
      </div>
      ```
    3. Commit und Push der Änderungen an `TERMGIT_HTML_PROJECT`.
2. Innerhalb des TerminoloGit-Projekts:
   1. Erstellen Sie in `input/includes/[CodeSystem | ValueSet]-[id]-previous-versions.xhtml` eine neue Zeile nach folgendem Muster. Die Zeile `OLD_BUSINESS_VERSION` stellt die Geschäftsversion der veralteten Terminologie dar.
      ```
      <tr><td><a href="YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].html">OLD_BUSINESS_VERSION</a></td><td><a onclick="createDiff('[CodeSystem | ValueSet]-[id].html', 'YYYYMMDD-hhmmss-[CodeSystem | ValueSet]-[id].html')" href="javascript:void(0);">Diff</a></td></tr>
      ```
    2. Commit und Push der Änderungen an das TerminoloGit-Projekt.

### Löschen einer Terminologie

> Bevor eine Terminologie aus TerminoloGit gelöscht wird, sollte ihr `status` auf `retired` gesetzt werden (siehe `CodeSystem.status` bzw. `ValueSet.status`).

1. Innerhalb des Projekts `TERMGIT_HTML_PROJECT`:
   1. Suchen und löschen Sie alle Dateien, die den folgenden Mustern entsprechen. **Überprüfen Sie, ob das Muster Dateien aus Terminologien enthält, die nicht gelöscht werden sollen. Ebenso kann es vorkommen, dass das Muster nicht alle Dateien erfasst, die zu der Terminologie gehören, die gelöscht werden soll.**
      1. `ls output/*[CodeSystem | ValueSet]-[id].*`
      2. `ls output/[CodeSystem | ValueSet]/[id].html`
   2. Commit und Push der Änderungen an das `TERMGIT_HTML_PROJECT`.
2. Innerhalb des TerminoloGit-Projekts:
   1. Suchen und löschen Sie die folgenden Dateien und Verzeichnisse:
      1. `input/includes/[CodeSystem | ValueSet]-[id]-previous-versions.xhtml`
      2. `input/includes/[CodeSystem | ValueSet]-[id]-download.xhtml`
      3. `input/redirects/[CodeSystem | ValueSet]/[id].html`
      4. `terminologies/[CodeSystem | ValueSet]-[id]/` **oder** `input/resources/[CodeSystem | ValueSet]-[id].xml`
   2. Entfernen Sie den Eintrag, der der gelöschten Terminologie entspricht, aus `terminologies/terminologiesMetadata.csv`.
   3. Übernehmen Sie die Änderungen und pushen Sie sie in das TerminoloGit-Projekt.
3. Entfernen Sie die Terminologie von allen FHIR®-Servern, auf die sie hochgeladen worden sein könnte.

### Eine Pipeline starten

Grundsätzlich gibt es vier Möglichkeiten, wie die GitLab-Pipeline gestartet werden kann:
1. Pushen eines Commits in den Standardbranch des Projekts.
2. Pushen eines Commits in einen beliebigen anderen Branch des Projekts. Anschließend muss die Pipeline in GitLab manuell gestartet werden (siehe [Manuelle Interaktion zu Ihrer Pipeline hinzufügen](https://docs.gitlab.com/ee/ci/pipelines/#add-manual-interaction-to-your-pipeline)).
3. Durch manuelles Starten einer Pipeline (siehe [Manuelles Ausführen einer Pipeline](https://docs.gitlab.com/ee/ci/pipelines/#run-a-pipeline-manually))
   1. Die Mindestanforderung für das manuelle Starten einer TerminoloGit-Pipeline ist die Angabe des `CI_COMMIT_TITLE`. Auf diese Weise wird ein Commit simuliert.
4. Beim Starten eines Integrationstests aus einem MaLaC-CT Projekt.

### Terminologien durchsuchen

Der HL7® FHIR® IG Publisher erstellt eine Reihe von statischen HTML-Seiten. Diese Seiten sind ideal für Nachforschungszwecke oder einfach zum Durchblättern, da alle Terminologien in einer gut strukturierten HTML-Seite dargestellt werden. Der Benutzer hat die Möglichkeit, verschiedene Codesysteme und Value-Sets in strukturierter Form abzurufen oder mit Hilfe der Suchfunktion nach bestimmten Konzepten zu suchen. Zwischen den Codesystemen und Value-Sets besteht immer eine Verknüpfung, um das Auffinden zusammengehöriger Terminologien zu erleichtern.

### Import von Terminologien

#### Automatischer Import von Terminologien

Um sicherzustellen, dass ein System immer auf dem neuesten Stand ist, gibt es verschiedene Möglichkeiten des automatischen Imports von Terminologien. Die hier vorgestellten Optionen konzentrieren sich auf den Import einer bestimmten Terminologie.

Grundsätzlich kann die folgende URL-Vorlage verwendet werden, um immer die neueste Version einer Terminologie abzurufen:

- Für Terminologien innerhalb des Verzeichnisses `terminologies/`:
  `[GITLAB_URL]/[PROJECT_PATH]/-/raw/[DEFAULT_BRANCH]/terminologies/[NAME_OF_TERMINOLOGY]/[NAME_OF_TERMINOLOGY][FORMAT]`
- Für Terminologien innerhalb des Verzeichnisses `input/resources/`:
  `[GITLAB_URL]/[PROJECT_PATH]/-/raw/[DEFAULT_BRANCH]/input/resources/[NAME_OF_TERMINOLOGY].xml`

Hier steht die
- `[GITLAB_URL]` für den Zugriff auf die GitLab-Instanz, in der sich das Git-Repository mit den Terminologien befindet (z. B. `https://gitlab.com`).
- `[PROJECT_PATH]` der Pfad zum Git-Repository mit den Terminologien (z. B. `elga-gmbh/termgit`).
- `[DEFAULT_BRANCH]` gibt den Namen des Standardzweigs des Git-Repository an (z. B. `main`).
- `[NAME_OF_TERMINOLOGY]` entspricht dem Typ der Terminologie (`CodeSystem` oder `ValueSet`) und der ID der Terminologie (z.B. `iso-3166-1-alpha-3`). Typ und id werden mit `-` verbunden, was zu `CodeSystem-iso-3166-1-alpha-3` führt.
- `[FORMAT]` entspricht der Dateierweiterung eines der unterstützten [Dateiformate](file_formats_de.md), z. B. `4.fhir.xml`.

Das Ergebnis kann dann wie folgt aussehen:

    https://gitlab.com/elga-gmbh/termgit/-/raw/main/terminologies/CodeSystem-iso-3166-1-alpha-3/CodeSystem-iso-3166-1-alpha-3.4.fhir.xml

Ausgehend von einem bestimmten Dateiformat einer Terminologie werden in den nächsten Punkten verschiedene Arten des Abrufs vorgestellt. Beachten Sie, dass die Beispiele hier auf dem österreichischen Terminologiebrowser [termgit.elga.gv.at](https://termgit.elga.gv.at) basieren.
1. Als Permalink zur Datei, ohne Versionierungsangaben:
   - Python:

         response = urllib2.urlopen('https://gitlab.com/elga-gmbh/termgit/-/raw/main/terminologies/CodeSystem-iso-3166-1-alpha-3/CodeSystem-iso-3166-1-alpha-3.2.claml.xml?inline=false')
   - Java:

         URL url = new URL("https://gitlab.com/elga-gmbh/termgit/-/raw/main/terminologies/CodeSystem-iso-3166-1-alpha-3/CodeSystem-iso-3166-1-alpha-3.2.claml.xml?inline=false");
         URLConnection connection = url.openConnection();
         InputStream is = connection.getInputStream();
         // ... dann die Datei herunterladen

2. Mit Git via ssh innerhalb eines lokalen Repositorys und den Git-Tags für die entsprechende Terminologie:
   - Erster Klon des Repositorys:

         git clone git@gitlab.com:elga-gmbh/termgit.git

   - Aktualisierung des lokalen Git-Repositorys (inkl. Git-Tags):

         git fetch --tags -f

   - Überprüfen des Unterschieds zwischen dem aktuellen Inhalt des lokalen Verzeichnisses und dem der Git-Tags einer Terminologie nach der Aktualisierung des Repositorys:

         git log HEAD..tags/CodeSystem-iso-3166-1-alpha-3

     oder

         git log HEAD..tags/1.0.3166.1.2.3

   - Checkout der neuesten Version einer Terminologie mit dem entsprechenden Git-Tag. **Hinweis:** Dadurch wird das gesamte Repository auf den Stand des Git-Tags gesetzt. Andere Terminologien können einen aktuelleren Stand haben.

         git checkout tags/CodeSystem-iso-3166-1-alpha-3

     oder

         git checkout tags/1.0.3166.1.2.3

3. Mit Git über ssh ohne ein lokales Repository und die Git-Tags für das entsprechende Terminologieverzeichnis. Es werden alle verfügbaren Download-Formate abgerufen:

       git archive -o C:/tmp/CS-ISO-3166-1-alpha-3.zip --remote git@gitlab.com:elga-gmbh/termgit.git CodeSystem-iso-3166-1-alpha-3:terminologies/CodeSystem-iso-3166-1-alpha-3

   oder

       git archive -o C:/tmp/CS-ISO-3166-1-alpha-3.zip --remote git@gitlab.com:elga-gmbh/termgit.git 1.0.3166.1.2.3:terminologies/CodeSystem-iso-3166-1-alpha-3

4. Mit GitLab API über REST für ein bestimmtes Download-Format (hier `.2.claml.xml`). `/` muss mit `%2f` escaped werden:

       curl https://gitlab.com/api/v4/projects/33179072/repository/files/terminologies%2fCodeSystem-iso-3166-1-alpha-3%2fCodeSystem-iso-3166-1-alpha-3.2.claml.xml?ref=main

5. Verwendung der FHIR® REST API, wenn ein FHIR® Server mit dem System verbunden ist:
   - curl:

         curl https://tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/iso-3166-1-alpha-3

   - für weitere Details siehe [http://www.hl7.org/fhir/overview-dev.html#Interactions](http://www.hl7.org/fhir/overview-dev.html#Interactions)

##### Abrufen von Metainformationen zu einem Git-Tag

Die [GitLab-API für Git-Tags](https://docs.gitlab.com/ee/api/tags.html) kann zur automatischen Überprüfung verwendet werden, ob eine bestimmte Terminologie aktualisiert wurde. Der folgende Befehl kann verwendet werden, um die Metadaten eines Git-Tags abzurufen:

    curl https://gitlab.com/api/v4/projects/33179072/repository/tags/CodeSystem-iso-3166-1-alpha-3

Die Metadaten enthalten unter anderem
- die aktuelle Version der Terminologie (`message`).
- das Datum, an dem der Git-Tag erstellt wurde (`created_at`).

#### Manueller Import von Terminologien

Neben dem automatischen Import von Terminologien ist es auch möglich, alle Terminologien manuell zu importieren. Dazu empfiehlt es sich, die Tag-News in GitLab zu aktivieren. Sie erhalten dann bei jeder Änderung eine automatische Benachrichtigung.

[![manual-import](input/images/manual_import_de.drawio.png "manual-import"){: style="width: 100%"}](input/images/manual_import_de.drawio.png)

### Validierung von Codes

Das System kann auch verwendet werden, um zu prüfen, ob ein bestimmter Code Teil eines Codesystems oder ValueSets ist. Dies funktioniert mit der FHIR®-Operation [`$validate-code` für CodeSysteme](http://www.hl7.org/fhir/codesystem-operation-validate-code.html) und [`$validate-code` für ValueSets](http://www.hl7.org/fhir/valueset-operation-validate-code.html).

     curl https://tergi.elga.gv.at/fhir-server/api/v4/ValueSet/appc-anatomie/$validate-code?system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie&code=0

[![validate-code](input/images/validate-code.png){: style="width: 100%"}](input/images/validate-code.png)

Wenn Sie den HAPI JPA Server verwenden, beachten Sie bitte die folgende Einschränkungen zur FHIR®-Operation `$validate-code`, die gemäß der FHIR R4-Spezifikation funktioniert:

* `[base]/CodeSystem/$validate-code` erlaubt keinen abschließenden Schrägstrich für den GET Parameter `url` (z.B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/$validate-code?code=100&url=https://termgit.elga.gv.at/CodeSystem/elga-e-health-anwendungen)
* `[base]/CodeSystem/[id]/$validate-code` (z. B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/appc-anatomie/$validate-code?code=100)
* `[base]/ValueSet/$validate-code` erlaubt keinen abschließenden Schrägstrich für die GET-Parameter `url` und `system` (z. B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/$validate-code?url=https://termgit.elga.gv.at/ValueSet/appc-anatomie&code=0&system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie)
* `[base]/ValueSet/[id]/$validate-code` erlaubt keinen abschließenden Schrägstrich für den GET-Parameter `system` (z. B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/appc-anatomie/$validate-code?system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie&code=0)

### Weitere FHIR®-Operationen, mit Einschränkungen des HAPI JPA Servers

* `[base]/CodeSystem/$lookup` erfordert einen abschließenden Schrägstrich für den GET-Parameter `system` (z.B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/CodeSystem/$lookup?code=100&system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie/)
* `[base]/ValueSet/$expand` erlaubt keinen abschließenden Schrägstrich für den GET-Parameter `url` (z. B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/$expand?url=https://termgit.elga.gv.at/ValueSet/appc-anatomie&system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie/)
* `[base]/ValueSet/[id]/$expand` (z. B. https://dev-tergi.elga.gv.at/fhir-server/api/v4/ValueSet/appc-anatomie/$expand?system=https://termgit.elga.gv.at/CodeSystem/appc-anatomie/)

### Hochladen von Terminologien auf FHIR®-Server

Die von TerminoloGit verwalteten Ressourcen können automatisch auf FHIR®-Server hochgeladen werden. Dies kann durch die Nutzung von [GitLab's Project-level Secure Files](https://docs.gitlab.com/ee/ci/secure_files/) erreicht werden.

Verwenden Sie die [Vorlage zur Angabe von FHIR®-Server](input/files/additional-fhir-server-template.json), füllen Sie die erforderlichen Informationen aus und erstellen Sie eine Datei für jeden zusätzlichen FHIR®-Server. Die Variable `FHIRServer` ist obligatorisch. Sie können zwischen `User`+`UserPassword` oder dem `TergiTunnelToken` wählen, die unbenutzte Variable lassen Sie bitte mit `""` leer. Weitere Informationen zu den Variablen finden Sie in der [setup](setup_de.md).

Fügen Sie nun die erstellte Datei Ihrer TerminoloGit Instanz hinzu:
[![Hinzufügen eines Secure Files in Gitlab](input/images/tergi-sec-file.png "Hinzufügen eines Secure Files in Gitlab"){: style="width: 100%"}](input/images/tergi-sec-file.png)

Alle neuen oder bearbeiteten Terminologien bzw. jene FHIR®-Ressourcen, die sich im Verzeichnis `input/resources` befinden, werden in der Folge auf die zusätzlichen FHIR®-Server geladen.