> **For the english version please click [here](ui_features_en.md).**

### UI-Funktionen

Das [TerminoloGit Template](https://gitlab.com/elga-gmbh/terminologit-template) definiert das Erscheinungsbild von TerminoloGit und bietet die folgenden speziellen Funktionen für CodeSystem- und ValueSet-Ressourcen:
- Durchsuchbarer narrativer Inhalt
- Download-Seite
- Frühere Versionen einer einzelnen Terminologie

#### Durchsuchbarer narrativer Inhalt

Der durchsuchbare narrative Inhalt für Terminologien ist eine optimierte Ansicht, um Konzepte innerhalb von CodeSystems und ValueSets leicht zu suchen und zu finden. Außerdem wird bei einem CodeSystem die Liste der Eigenschaften standardmäßig eingeklappt, wenn es mehr als 5 Eigenschaften definiert. Bei ValueSets ist die logische Inhaltsdefinition (CLD) standardmäßig eingeklappt.

#### Download-Seite

Die Download-Seite bietet die Möglichkeit, die Terminologie in [allen unterstützten Dateiformaten](file_formats_de.md) abzurufen.

> Beachten Sie, dass für intensionale ValueSets derzeit nur FHIR® XML oder FHIR® JSON unterstützt wird.

#### Frühere Version einer einzelnen Terminologie

Alte Versionen einer Terminologie können über die Registerkarte "Previous versions" abgerufen werden. Die angezeigte Tabelle enthält die folgenden Spalten:

- `Version Number`: Diese Spalte enthält die Versionsnummer der jeweiligen Version der Terminologie.
- `Current Version vs. Outdated Version`: Mit Hilfe des [W3C HTML Diff Tool](https://services.w3.org/htmldiff) können die Unterschiede zwischen der alten und der aktuellen Version der Terminologie angezeigt werden.

Gibt es keine alten Versionen zu einer Terminologie, ist die Tabelle leer.

In der Anzeige ist eine alte Version an einem roten Banner am oberen Rand der Seite zu erkennen. Über diesen Banner kann auch direkt zur aktuellen Version gewechselt werden.