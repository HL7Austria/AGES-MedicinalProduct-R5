> **For the english version please click [here](technical_documentation_en.md).**

### TerminoloGit

TerminoloGit ermöglicht es, Terminologien zu erstellen, zu bearbeiten und zu veröffentlichen. Dazu gehören Codesysteme, Value-Sets sowie Concept-Maps.

Hier finden Sie die technische Dokumentation zu TerminoloGit, die aus den folgenden Teilen besteht:
- [Architektur](architecture_de.md)
- [Einrichtung](setup_de.md)
- [Verwendung](use_cases_de.md)
- [Dateiformate](file_formats_de.md)
- [UI-Funktionen](ui_features_de.md)

### Aktueller Stand der Entwicklung

Die folgenden beiden Repositories dienen der Weiterentwicklung von TerminoloGit.

| Projektname | Repository-URL | Beschreibung | GitLab-Projekt-ID | GitLab-Pages-URL |
| --- | --- | --- | --- | --- |
| TerminoloGit Dev | [https://gitlab.com/elga-gmbh/termgit-dev](https://gitlab.com/elga-gmbh/termgit-dev) | Repository für die technische Entwicklung von TerminoloGit.<br/><br/>*Hinweis:* Der Inhalt der letzten erfolgreichen Pipeline eines beliebigen Git-Branches dieses Repositorys wird unter der angegebenen GitLab-Pages-URL angezeigt. | 21743825 | [https://elga-gmbh.gitlab.io/termgit-dev/](https://elga-gmbh.gitlab.io/termgit-dev/) |
| TerminoloGit Dev HTML | [https://gitlab.com/elga-gmbh/terminologit-dev-html](https://gitlab.com/elga-gmbh/terminologit-dev-html) | Repository für die statischen HTML-Seiten, die vom HL7® FHIR® IG Publisher erstellt werden, basierend auf dem `master`-Branch von [https://gitlab.com/elga-gmbh/termgit-dev](https://gitlab.com/elga-gmbh/termgit-dev). | 28239847 | [https://dev.termgit.elga.gv.at](https://dev.termgit.elga.gv.at) |

### Beitragen/Contributing

Vielen Dank für Ihr Interesse an einer Mitarbeit! Im Sinne des Open-Source-Gedankens würden sich die Entwickler sehr über einen Verweis auf TerminoloGit, die Nutzung dieses Projekts oder von Unterprojekten und vor allem über eine aktive Beteiligung freuen. Es gibt viele Möglichkeiten, zu TerminoloGit beizutragen. Beginnen Sie mit der [CONTRIBUTING.md in unserem Dev-Repo](https://gitlab.com/elga-gmbh/termgit-dev/-/blob/stable/CONTRIBUTING.md).

### Referenz-Implementierungen

#### Österreichischer e-Health Terminologie Server

Die erste produktive Implementierung von TerminoloGit war der österreichische e-Health Terminologieserver, der eine Vielzahl von verschiedenen Terminologien mit unterschiedlichen Strukturen aus verschiedenen internationalen, nationalen und lokalen Quellen verwendet. Dieser Server wurde im Januar 2022 in Betrieb genommen und wird in der österreichischen E-Health-Domäne, insbesondere in der österreichischen Elektronischen Gesundheitsakte (ELGA), aktiv genutzt. Die aktuellen Terminologien und die Governance können unter [termgit.elga.gv.at](https://termgit.elga.gv.at) eingesehen werden.

### Lizenz und rechtliche Bedingungen

TerminoloGit ist lizenziert unter der GNU General Public License v3.0 oder höher - siehe die Datei [LICENSE.md](https://gitlab.com/elga-gmbh/termgit-dev/-/blob/stable/LICENSE.md) für Details.

#### HL7®

HL7®, HEALTH LEVEL SEVEN® und FHIR® sind Marken im Besitz von Health Level Seven International, eingetragen beim United States Patent and Trademark Office.

Dieser Implementierungsleitfaden enthält und verweist auf geistiges Eigentum, das Dritten gehört ("Third Party IP"). Mit der Annahme dieser Lizenzbedingungen werden keine Rechte in Bezug auf das geistige Eigentum Dritter gewährt. Der Lizenznehmer ist allein dafür verantwortlich, alle erforderlichen Lizenzen oder Genehmigungen für die Nutzung des geistigen Eigentums Dritter in Verbindung mit der Spezifikation oder auf andere Weise zu ermitteln und einzuholen.