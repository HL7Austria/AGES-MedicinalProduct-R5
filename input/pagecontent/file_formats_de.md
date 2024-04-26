> **For the english version please click [here](file_formats_en.md).**

### Dateiformate Übersicht

Die folgenden Dateiformate werden derzeit unterstützt:

| Name | Dateiendung | Zeichenkodierung | Hinweis |
| --- | --- | --- | --- |
| FHIR® R4B xml | `.4.fhir.xml` | UTF-8 | |
| FHIR® R4B json | `.4.fhir.json` | UTF-8 | |
| fsh v1 | `.1.fsh` | UTF-8 | |
| fsh v2 | `.2.fsh` | UTF-8 | |
| propCSV v1 csv | `.1.propcsv.csv` | cp-1252 oder UTF-8 bei Encoding-Fehler | |
| propCSV v1 xlsx | `.1.propcsv.xlsx` | UTF-8 | |
| ClaML v2 | `.2.claml.xml` | UTF-8 | |
| ClaML v3 | `.3.claml.xml` | UTF-8 | |
| SVSextELGA v1 | `.1.svsextelga.xml` | UTF-8 | **Warnung! DEPRECATED!**<br/>Dieses Format kann technisch nicht alle Informationen enthalten,<br/>die in den anderen Formaten verfügbar sind.<br/>Dieses Format ist nur noch für Legacy-Zwecke verfügbar. |
| SVSextELGA v2 | `.2.svsextelga.xml` | UTF-8 | **Warnung! DEPRECATED!**<br/>Dieses Format kann technisch nicht alle Informationen enthalten,<br/>die in den anderen Formaten verfügbar sind.<br/>Dieses Format ist nur noch für Legacy-Zwecke verfügbar.<br/>Es sind jedoch alle Konzept-Properties verfügbar. |
| outdatedCSV v1 | `.1.outdatedcsv.csv` | UTF-8 | **Warnung! DEPRECATED!**<br/>Dieses Format kann technisch nicht alle Informationen enthalten,<br/>die in den anderen Formaten verfügbar sind.<br/>Dieses Format ist nur noch für Legacy-Zwecke verfügbar. |
| outdatedCSV v2 | `.2.outdatedcsv.csv`  | UTF-8 | **Warnung! DEPRECATED!**<br/>Dieses Format kann technisch nicht alle Informationen enthalten,<br/>die in den anderen Formaten verfügbar sind.<br/>Dieses Format ist nur noch für Legacy-Zwecke verfügbar.<br/>Es sind jedoch alle Konzept-Properties verfügbar. |

### Haftungsausschluss bezüglich der Konvertierung zwischen Dateiformaten

> *Bitte beachten Sie, dass das propCSV-Format das Kernformat für die Konvertierung zwischen den verschiedenen Dateiformaten darstellt. Darüber hinaus ist die XLSX-Version von propCSV vollständig für Menschen lesbar.*
>
> *Wenn es z.B. ein Element in der FHIR®-Spezifikation gibt, das in propCSV nicht unterstützt wird, kann es nicht in die anderen Dateiformate konvertiert werden.*

### FHIR® R4B

Den Aufbau der FHIR®-Ressourcen entnehmen Sie bitte der entsprechenden Dokumentation, z.B.:
- [CodeSystem](http://hl7.org/fhir/R4B/codesystem.html)
- [ValueSet](http://hl7.org/fhir/R4B/valueset.html)
- [ConceptMap](http://hl7.org/fhir/R4B/conceptmap.html)

Die XML-Darstellung für eine Ressource wird mit diesem Format beschrieben (siehe [XML-Darstellung von Ressourcen](http://hl7.org/fhir/R4B/xml.html)):

    <name xmlns="http://hl7.org/fhir" (attrA="value")>
      <!-- von Ressource: id, meta, implicitRules, und language -->
      <nameA><!-- 1..1 Typ Beschreibung des Inhalts --><nameA>
      <nameB[x]><!-- 0..1 Typ1|Typ1 Beschreibung --></nameB[x]>
      <nameC> <!-- 1..* -->
        <nameD><!-- 1..1 type>Relevante Elemente --></nameD>
      </nameC>
    <name>

Die JSON-Darstellung für eine Ressource basiert auf dem [JSON-Format, beschrieben in STD 90 (RFC 8259)](https://www.rfc-editor.org/info/std90), und wird mit diesem Format beschrieben (siehe [JSON-Darstellung von Ressourcen](http://hl7.org/fhir/R4B/json.html)):

    {
      "resourceType" : "[Ressourcentyp]",
      // von Quelle: property0
      "property1" : "<[primitiv]>", // Kurzbeschreibung
      "property2" : { [Datentyp] }, // Kurzbeschreibung
      "property3" : { // Kurzbeschreibung
        "propertyA" : { CodeableConcept }, // Kurzbeschreibung (Beispiel)
      },
      "property4" : [{ // Kurzbeschreibung
        "propertyB" : { Referenz(ResourceType) } // R!  Kurzbeschreibung
      }]
    }

### FHIR® Shorthand (FSH)

FHIR® Shorthand (FSH) ist eine domänenspezifische Sprache zur Definition des Inhalts von FHIR® Implementation Guides (IG). Die Sprache wurde speziell für diesen Zweck entwickelt, ist einfach und kompakt und ermöglicht es dem Autor, seine Absichten auszudrücken, ohne sich Gedanken über die zugrundeliegende FHIR®-Mechanik machen zu müssen. FSH kann mit einem beliebigen Texteditor erstellt und aktualisiert werden. Da es sich um Text handelt, ermöglicht es eine verteilte, teambasierte Entwicklung unter Verwendung von Quellcode-Kontrolltools wie GitHub.

Dokumentation von FSH:
- [fsh v1](http://hl7.org/fhir/uv/shorthand/2021Sep/)
- [fsh v2](http://hl7.org/fhir/uv/shorthand/)

### Proprietäres CSV (propCSV) - CSV und XLSX

Das proprietäre CSV (propCSV) ermöglicht eine vereinfachte Bearbeitung von Terminologien. Dieses Format basiert auf der FHIR®-Spezifikation für Codesysteme und Value-Sets. Es ermöglicht die Dokumentation der Metadatenelemente sowie der Konzeptelemente einer Terminologie.

Die FHIR®-Spezifikation definiert die Pflichtelemente für Codesysteme (http://hl7.org/fhir/codesystem.html#resource) und Value-Sets (http://hl7.org/fhir/valueset.html#resource). Die Namen der entsprechenden Elemente dürfen nicht verändert werden. Generell dürfen keine anderen als die in der FHIR®-Spezifikation definierten Elemente verwendet werden, es sei denn, es wird eine FHIR®-Erweiterung verwendet. In einigen Ausnahmefällen kann es jedoch notwendig sein, benutzerdefinierte Elemente hinzuzufügen (z.B. `parent` und `parentSystem` zur Unterstützung hierarchischer Strukturen in `ValueSet.expansion`), um bestimmte Anforderungen zu unterstützen, die noch auf der FHIR®-Spezifikation basieren.

Der Wert eines Elements wird in die jeweiligen FHIR®-Datentypen (uri, identifier, string, code, ...) konvertiert und bei erfolgreicher Konvertierung gespeichert.

Das propCSV wird sowohl als CSV- als auch als XLSX-Datei bereitgestellt. **Für die Bearbeitung wird die XLSX-Datei empfohlen.

#### Dateistruktur

Die ersten beiden Zeilen bestehen aus den Metadatenelementen für die Terminologie, d.h. in der ersten Zeile wird der Name des Elements angegeben, in der zweiten Zeile wird der Wert des entsprechenden Elements dokumentiert.

Eine Leerzeile trennt die Metadatenelemente von den Konzeptelementen.

Bei den Konzeptelementen folgt auf eine Zeile, in der die erforderlichen Konzeptelementnamen angegeben sind, die jeweiligen Werte für jedes Konzept, das Teil der Terminologie sein soll.

Die Metadatenelemente und Konzeptelemente können in beliebiger Reihenfolge angegeben werden. Nach dem **Schlüssel-Wert-Prinzip** wird immer der Schlüssel gelesen, der dem darunter stehenden Wert die Bedeutung gibt.

#### Codesystem

Die folgende Liste enthält sowohl erforderliche als auch empfohlene Metadatenelemente für Codesysteme. Eine Beispieldatei kann hier heruntergeladen werden: **[Codesystem](input/files/CodeSystem-cs-import-template.1.propcsv.xlsx)** *Hinweis: Zellen, die bearbeitet werden müssen, sind gelb hervorgehoben*

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Kardinalität</th>
            <th>Beschreibung</th>
            <th>Beispiel</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>resource</code></td>
            <td><strong>1..1</strong></td>
            <td>Gibt die Art der Terminologie an. Fester Wert: <code>CodeSystem</code></td>
            <td><code>CodeSystem</code></td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td><strong>1..1</strong></td>
            <td>Logische ID dieses Artefakts.</td>
            <td><code>cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>url</code></td>
            <td><strong>1..1</strong></td>
            <td>Kanonischer Identifikator für dieses Codesystem, dargestellt als URI (weltweit eindeutig)
                (<code>Coding.system</code>).</td>
            <td><code>https://my-terminology-server.com/CodeSystem/cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>identifier</code></td>
            <td>0..*</td>
            <td>Zusätzlicher Identifikator für das Codesystem ("Business Identifier"). Derzeit wird nur  <code>urn:oid:</code>
                unterstützt. Der angegebene Wert entspricht somit <code>Identifier.value</code> (vgl. <a
                    href="http://www.hl7.org/fhir/datatypes.html#Identifier">http://www.hl7.org/fhir/datatypes.html#Identifier</a>).
            </td>
            <td><code>1.25.256.25.8.9</code></td>
        </tr>
        <tr>
            <td><code>version</code></td>
            <td><strong>1..1</strong></td>
            <td>Business-Version des Codesystems (<code>Coding.version</code>).</td>
            <td><code>1.0.0+20230601</code></td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>0..1</td>
            <td>Name dieses Codesystems (computerfreundlich).</td>
            <td><code>cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>title</code></td>
            <td>0..1</td>
            <td>Name dieses Codesystems (menschenfreundlich).</td>
            <td><code>CS Import Template</code></td>
        </tr>
        <tr>
            <td><code>status</code></td>
            <td><strong>1..1</strong></td>
            <td><code>draft</code> | <code>active</code> | <code>retired</code> | <code>unknown</code></td>
            <td><code>active</code></td>
        </tr>
        <tr>
            <td><code>date</code></td>
            <td>0..1</td>
            <td>Datum der letzten Änderung. Das Format ist <code>YYYY-MM-DD</code>.</td>
            <td><code>2015-02-07</code></td>
        </tr>
        <tr>
            <td><code>contact</code></td>
            <td>0..*</td>
            <td>Kontaktinformationen des Herausgebers. Alle Subattribute (vgl. <a
                    href="http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail">http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail</a>)
                werden in der ersten Ebene mit einem <code>|</code> und in der zweiten Ebene mit einem <code>^</code> verbunden.<br>
                <ul>
                    <li><code>name</code> - Name einer Kontaktperson.</li>
                    <li><code>telecom</code> - Kontaktangaben zur Person oder Organisation.<ul>
                            <li><code>system</code> - <code>phone</code> | <code>fax</code> | <code>email</code> |
                                <code>pager</code> | <code>url</code> | <code>sms</code> | <code>other</code></li>
                            <li><code>value</code> - Die eigentlichen Angaben zur Kontaktstelle</li>
                            <li><code>use</code> - <code>home</code> | <code>work</code> | <code>temp</code> |
                                <code>old</code> | <code>mobile</code> - Zweck dieser Kontaktstelle</li>
                            <li><code>rank</code> - Bevorzugte Reihenfolge der Verwendung (1 = höchste)</li>
                            <li><code>periodStart</code> - Anfangszeitpunkt mit inklusiver Grenze, wann die Kontaktstelle
                                in Gebrauch war/ist.</li>
                            <li><code>periodEnd</code> - Endzeitpunkt mit inklusiver Grenze, falls nicht fortlaufend, wann die
                                Kontaktstelle in Gebrauch war/ist.</li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td><code>John Doe|url^https://my-terminology-publishing.com^^^^</code></td>
        </tr>
        <tr>
            <td><code>description</code></td>
            <td>0..1</td>
            <td>Freitext-Beschreibung des Codesystems.</td>
            <td></td>
        </tr>
        <tr>
            <td><code>copyright</code></td>
            <td>0..1</td>
            <td>Einschränkungen bei der Nutzung und/oder Veröffentlichung.</td>
            <td></td>
        </tr>
        <tr>
            <td><code>content</code></td>
            <td><strong>1..1</strong></td>
            <td><code>not-present</code> | <code>example</code> | <code>fragment</code> | <code>complete</code> |
                <code>supplement</code></td>
            <td><code>complete</code></td>
        </tr>
        <tr>
            <td><code>count</code></td>
            <td>0..1</td>
            <td>Gesamtzahl der Konzepte im Codesystem</td>
            <td><code>238</code></td>
        </tr>
        <tr>
            <td><code>property</code></td>
            <td>0..*</td>
            <td>Zusätzliche Informationen zu jedem Konzept. Alle Unterattribute werden durch ein
                <code>|</code> verbunden.<br>
                <ul>
                    <li><code>code</code> <em><strong>required</strong></em> - Identifiziert die Eigenschaft auf den Konzepten,
                        und wann in Operationen darauf Bezug genommen wird.</li>
                    <li><code>uri</code> - Formaler Identifikator für die Eigenschaft</li>
                    <li><code>description</code> - Warum die Eigenschaft definiert ist und/oder was sie vermittelt</li>
                    <li><code>type</code> <em><strong>required</strong></em> - <code>code</code> | <code>Coding</code> |
                        <code>string</code> | <code>integer</code> | <code>boolean</code> | <code>dateTime</code> |
                        <code>decimal</code></li>
                </ul>
            </td>
            <td><code>child|||code</code></td>
        </tr>
    </tbody>
</table>

Die folgende Liste enthält sowohl erforderliche als auch empfohlene Konzeptelemente für Codesysteme:


<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Kardinalität</th>
            <th>Beschreibung</th>
            <th>Beispiel</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>code</code></td>
            <td><strong>1..1</strong></td>
            <td>Code, der den Begriff identifiziert.</td>
            <td><code>123456</code></td>
        </tr>
        <tr>
            <td><code>display</code></td>
            <td>0..1</td>
            <td>Text, der den Usern angezeigt werden soll.</td>
            <td><code>bear</code></td>
        </tr>
        <tr>
            <td><code>definition</code></td>
            <td>0..1</td>
            <td>Formale Definition</td>
            <td><code>Bären sind fleischfressende Säugetiere aus der Familie der Ursidae.</code></td>
        </tr>
        <tr>
            <td><code>designation</code></td>
            <td>0..*</td>
            <td>Zusätzliche Angaben zum Konzept. Alle Subattribute werden durch ein <code>|</code> verbunden.<br>
                <ul>
                    <li><code>language</code> - Menschliche Sprache der zusätzlichen Angaben.</li>
                    <li><code>use</code> - Details zur Verwendung der zusätzlichen Angaben.</li>
                    <li><code>value</code> <em><strong>required</strong></em> - Der Klartext dieser zusätzlichen Angaben.</li>
                </ul>
            </td>
            <td><code>de-AT|^^^^|Bär</code> oder
                <code>|http://snomed.info/sct^^900000000000003001^Fully specified name^|Ursidae</code></td>
        </tr>
        <tr>
            <td><code>property</code></td>
            <td>0..*</td>
            <td>Wert der Eigenschaft für das Konzept. Alle Subattribute werden mit einem <code>|</code> verbunden.<br>
                <ul>
                    <li><code>code</code> <em><strong>required</strong></em> - Identifiziert die Eigenschaft auf den Konzepten,
                        und wann in Operationen darauf Bezug genommen wird.</li>
                    <li><code>value</code> <em><strong>required</strong></em> - Wert der Eigenschaft für dieses Konzept.
                    </li>
                    <li><code>type</code> <em><strong>required</strong></em> - <code>code</code> | <code>Coding</code> |
                        <code>string</code> | <code>integer</code> | <code>boolean</code> | <code>dateTime</code> |
                        <code>decimal</code></li>
                </ul>
            </td>
            <td><code>Farbe|braun|string</code></td>
        </tr>
    </tbody>
</table>

#### Value-Sets

Die folgende Liste enthält sowohl erforderliche als auch empfohlene Metadatenelemente für Value-Sets. Eine Beispieldatei kann hier heruntergeladen werden: **[Value-Set](input/files/ValueSet-vs-import-template.1.propcsv.xlsx)** *Hinweis: Zellen, die bearbeitet werden müssen, sind gelb hinterlegt.


<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Kardinalität</th>
            <th>Beschreibung</th>
            <th>Beispiel</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>resource</code></td>
            <td><strong>1..1</strong></td>
            <td>Gibt die Art der Terminologie an. Fester Wert: <code>ValueSet</code></td>
            <td><code>ValueSet</code></td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td><strong>1..1</strong></td>
            <td>Logische ID dieses Artefakts.</td>
            <td><code>vs-import-template</code></td>
        </tr>
        <tr>
            <td><code>url</code></td>
            <td><strong>1..1</strong></td>
            <td>Kanonischer Identifikator für dieses Codesystem, dargestellt als URI (weltweit eindeutig).</td>
            <td><code>https://my-terminology-server.com/ValueSet/vs-import-template</code></td>
        </tr>
        <tr>
            <td><code>identifier</code></td>
            <td>0..*</td>
            <td>Zusätzlicher Identifikator für das Value-Set ("Business Identifier"). Derzeit wird nur <code>urn:oid:</code> is
                unterstützt. Der angegebene Wert entspricht somit <code>Identifier.value</code> (vgl. <a
                    href="http://www.hl7.org/fhir/datatypes.html#Identifier">http://www.hl7.org/fhir/datatypes.html#Identifier</a>).
            </td>
            <td><code>1.2.3.4.5.6.7.9.10</code></td>
        </tr>
        <tr>
            <td><code>version</code></td>
            <td><strong>1..1</strong></td>
            <td>Business-Version des Value-Sets.</td>
            <td><code>1.0.0+20230601</code></td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>0..1</td>
            <td>Name dieses Value-Sets (computerfreundlich).</td>
            <td><code>vs-import-template</code></td>
        </tr>
        <tr>
            <td><code>title</code></td>
            <td>0..1</td>
            <td>Name dieses Value-Sets (menschenfreundlich).</td>
            <td><code>VS Import Template</code></td>
        </tr>
        <tr>
            <td><code>status</code></td>
            <td><strong>1..1</strong></td>
            <td><code>draft</code> | <code>active</code> | <code>retired</code> | <code>unknown</code></td>
            <td><code>active</code></td>
        </tr>
        <tr>
            <td><code>date</code></td>
            <td>0..1</td>
            <td>Datum der letzten Änderung. Das Format ist <code>YYYY-MM-DD</code>.</td>
            <td><code>2015-02-07</code></td>
        </tr>
        <tr>
            <td><code>contact</code></td>
            <td>0..*</td>
            <td>Kontaktinformationen des Herausgebers. Alle Subattribute (vgl. <a
                    href="http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail">http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail</a>)
                werden in der ersten Ebene mit einem <code>|</code> und in der zweiten Ebene mit einem <code>^</code> verbunden.<br>
                <ul>
                    <li><code>name</code> - Name einer Kontaktperson.</li>
                    <li><code>telecom</code> - Kontaktangaben zur Person oder Organisation.<ul>
                            <li><code>system</code> - <code>phone</code> | <code>fax</code> | <code>email</code> |
                                <code>pager</code> | <code>url</code> | <code>sms</code> | <code>other</code></li>
                            <li><code>value</code> - Die eigentlichen Angaben zur Kontaktstelle</li>
                            <li><code>use</code> - <code>home</code> | <code>work</code> | <code>temp</code> |
                                <code>old</code> | <code>mobile</code> - Zweck dieser Kontaktstelle</li>
                            <li><code>rank</code> - Bevorzugte Reihenfolge der Verwendung (1 = höchste)</li>
                            <li><code>periodStart</code> - Anfangszeitpunkt mit inklusiver Grenze, wann die Kontaktstelle
                                in Gebrauch war/ist.</li>
                            <li><code>periodEnd</code> - Endzeitpunkt mit inklusiver Grenze, falls nicht fortlaufend, wann die
                                Kontaktstelle in Gebrauch war/ist.</li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td><code>John Doe|url^https://my-terminology-publishing.com^^^^</code></td>
        </tr>
        <tr>
            <td><code>description</code></td>
            <td>0..1</td>
            <td>Freitext-Beschreibung des Value-Sets.</td>
            <td></td>
        </tr>
        <tr>
            <td><code>copyright</code></td>
            <td>0..1</td>
            <td>Einschränkungen bei der Nutzung und/oder Veröffentlichung.</td>
            <td></td>
        </tr>
    </tbody>
</table>

Die folgende Liste enthält sowohl erforderliche als auch empfohlene Konzeptelemente für Value-Sets: 


<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Kardinalität</th>
            <th>Beschreibung</th>
            <th>Beispiel</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>system</code></td>
            <td><strong>1..1</strong></td>
            <td>Das Codesystem, aus dem die Codes stammen.</td>
            <td><code>https://my-terminology-server.com/CodeSystem/cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>version</code></td>
            <td>0..1</td>
            <td>Spezifische Version des Codesystems, auf das Bezug genommen wird.</td>
            <td><code>1.0.0+20230601</code></td>
        </tr>
        <tr>
            <td><code>code</code></td>
            <td><strong>1..1</strong></td>
            <td>Code oder Expression aus dem System</td>
            <td><code>123456</code></td>
        </tr>
        <tr>
            <td><code>display</code></td>
            <td>0..1</td>
            <td>Text, der für diesen Code in diesem Value-Set angezeigt werden soll.</td>
            <td><code>bear</code></td>
        </tr>
        <tr>
            <td><code>designation</code></td>
            <td>0..*</td>
            <td>Zusätzliche Angaben zum Konzept. Alle Subattribute werden durch ein <code>|</code> verbunden.<br>
                <ul>
                    <li><code>language</code> - Menschliche Sprache der zusätzlichen Angaben.</li>
                    <li><code>use</code> - Details zur Verwendung der zusätzlichen Angaben.</li>
                    <li><code>value</code> <em><strong>required</strong></em> - Der Klartext dieser zusätzlichen Angaben.</li>
                </ul>
            </td>
            <td><code>de-AT|^^^^|Bär</code> or
                <code>|http://snomed.info/sct^^900000000000003001^Fully specified name^|Ursidae</code></td>
        </tr>
        <tr>
            <td><code>exclude</code></td>
            <td>0..1</td>
            <td>Als Gegenteil von "include" erlaubt dies, ein bestimmtes Konzept eines Codesystems explizit auszuschließen. Auch
                ganze Codesysteme oder Value-Sets mit all ihren Konzepten können ausgeschlossen werden. Zusätzlich können Codesystem-
                Filter verwendet werden, um mehrere Konzepte auf der Grundlage ihrer Eigenschaften auszuschließen. 
                <code>true</code>
                wenn die Zeile in der propCSV als Ausschluss interpretiert werden soll. Wenn nicht angegeben, wird
                <code>false</code> angenommen, d. h. die Zeile wird als Einschluss interpretiert.<br/><br/><em>Hinweis: Mindestens eine
                    Zeile muss einen Einschluss darstellen.</em></td>
            <td><code>true</code></td>
        </tr>
        <tr>
            <td><code>parent</code></td>
            <td>0..1</td>
            <td>Code des übergeordneten Codes / Elternteils dieses Konzepts. Kombiniert mit <code>parentSystem</code> ist  dieses Element notwendig,
                wenn es sich um hierarchische Value-Sets handelt. In einem FHIR®-ValueSet führt dies dann zu einer hierarchischen
                Erweiterung, d.h. <code>ValueSet.expansion.contains.contains</code>.</td>
            <td><code>123457</code></td>
        </tr>
        <tr>
            <td><code>parentSystem</code></td>
            <td>0..1</td>
            <td>Codesystem des übergeordneten Codes / Elternteils dieses Konzepts. Erforderlich, wenn <code>parent</code> verwendet wird.</td>
            <td><code>https://my-terminology-server.com/CodeSystem/cs-import-template</code></td>
        </tr>
    </tbody>
</table>

### ClaML v2 und v3

ClaML (Classification Markup Language) ist ein spezielles XML-Datenformat für Klassifikationen. Das ClaML-Dateiformat unterstützt in erster Linie Codesysteme.

Die folgenden Elemente beschreiben die Metadaten einer Terminologie:

| Element | Beschreibung |
| --- | --- |
| `Title` | Enthält den Namen (Attribut `name`), die Version (Attribut `version`) sowie das Gültigkeitsdatum (Attribut `date`, Format: `YYYY-MM-DD`). |
| `Identifier` | Enthält die OID der Terminologie im Attribut `uid`. |
| `Authors` | Enthält ein oder mehrere `Author`-Elemente, die den Namen (Attribut `name`) des Autors und die Kontaktangaben als Elementinhalt enthalten. |
| `Meta` | Mehrere `Meta`-Elemente enthalten weitere Informationen als Schlüssel-Werte-Paare. |

Die am häufigsten verwendeten `Meta`-Elemente sind:
- `titleLong` - Von Menschen lesbarer Titel
- `resource` - Gibt den Typ der Terminologie an (z.B. `CodeSystem`, `ValueSet`)
- `id` - Logische Kennung dieses Artefakts
- `url` - Kanonischer Bezeichner für diese Terminologie, dargestellt als URI (global eindeutig)
- `status` - `draft` \| `active` \| `retired` \| `unknown`
- `description` - Deutsche Beschreibung der Terminologie
- `description_eng` - Englische Beschreibung der Terminologie
- `content` - Nur für Codesysteme relevant. `not-present` \| `example` \| `fragment` \| `complete` \| `supplement`
- `website` - Link zur Quelle usw.
- `copyright` - Verwendung und/oder Veröffentlichungsbeschränkungen.
- `version_description` - Beschreibung der Version
- `property` - Deklariert die Eigenschaften, die im Rahmen der Konzepte dieser Terminologie zu erwarten sind

Die Konzepte werden als `Class`-Elemente dargestellt:
- `Class/@code` - Code des Konzepts
- `Class/Rubric[@kind='preferred']` - Darstellung des Konzepts
- `Class/Rubric[@kind='note']` - ausführlichere Beschreibung (Anwendungsbeschreibung) des Konzepts
- `Class/Meta[@name='TS_ATTRIBUTE_HINTS']` - Hinweise auf die Anwendung des Konzepts
- `Class/Meta[@name='TS_ATTRIBUTE_MEANING']` oder `Class/Rubric[@kind='designation']` mit `de-AT` - deutsche Sprachvariante
- `Class/Meta[@name='Level']` und `Class/Meta[@name='Type']` - Abbildung der Hierarchie
- `Class/SubClass` - gibt die untergeordneten Konzepte dieses Konzepts an
- `Class/SuperClass` - gibt die übergeordneten Konzepte dieses Konzepts an.

### SVSextELGA v1 und v2

> ***HINWEIS:*** Dieses Dateiformat ist **deprecated**. SVSextELGA wird bis auf Weiteres weiterhin unterstützt. Es werden jedoch keine weiteren Entwicklungen für dieses Format durchgeführt. Daher kann dieses Dateiformat technisch nicht alle Informationen enthalten, die in nicht veralteten Dateiformaten verfügbar sind. Außerdem wird dieses Format mittelfristig (ca. 2025) vollständig abgeschafft werden.

Das unterstützte SVS basiert auf dem IHE Sharing Value Set Format und wurde für ELGA-Zwecke erweitert. Dieses XML-Format unterstützt sowohl Codesysteme als auch Value-Sets.

Das Root-Element `valueSet` enthält die Metadaten der Terminologie als Attribute:
- `name` - Name der Terminologie
- `displayName` - menschenlesbarer Name der Terminologie
- `beschreibung` - Beschreibung der Terminologie auf Deutsch
- `description` - Beschreibung der Terminologie in englischer Sprache
- `effectiveDate` - Gültigkeitsdatum
- `id` - OID der Terminologie
- `last_change_date` - Datum der letzten Änderung
- `version` - Version der Terminologie
- `website` - Link zur Quelle usw.

Das Element `conceptList` enthält die als `concept`-Elemente dargestellten Konzepte. Die folgende Liste erläutert die wichtigsten Attribute des Elements `concept`:
- `code` - Code, der das Konzept identifiziert
- `displayName` - Text, der für diesen Code in dieser Value-Set angezeigt wird
- `displayNameAlt` - Alternativer Anzeigename
- `codeSystem` - OID des Codesystems, aus dem der Code stammt
- `concept_beschreibung` - detailliertere Beschreibung (Anwendungsbeschreibung) des Konzepts
- `deutsch` - deutsche Sprachvariante, Bedeutung
- `einheit_codiert` - kodierte Darstellung der Einheit eines Prüfergebnisses
- `einheit_print` - menschenlesbare Form der Einheit eines Prüfergebnisses
- `hinweise` - Anmerkungen zur Anwendung des Konzepts
- `level` - gibt die Ebene des Konzepts innerhalb einer Hierarchie an
- `orderNumber` - Index zur Festlegung der Reihenfolge der Konzepte (nur für Value-Sets relevant)
- `parentCodeSystemName` - kanonische Url des Codesystems, aus dem der Code stammt
- `relationships` - mögliche Verbindungen zu anderen Konzepten
- `type` - Typ des Konzepts (`L` - Blatt, `S` - spezialisierbar, `A` - abstrakt, `D` - veraltet)

In Version 2 von SVSextELGA können undefinierte Attribute/Properties als zusätzliche Konzeptattribute aufgenommen werden.

### Veraltetes CSV (outdatedcsv) v1 und v2

> ***HINWEIS:*** Dieses Dateiformat ist **deprecated**. Das outdatedcsv wird bis auf Weiteres weiterhin unterstützt. Es werden jedoch keine weiteren Entwicklungen für dieses Format durchgeführt. Daher kann dieses Dateiformat technisch nicht alle Informationen enthalten, die in nicht veralteten Dateiformaten verfügbar sind. Außerdem wird dieses Format mittelfristig (ca. 2025) vollständig abgeschafft werden.

Das veraltete CSV (outdatedcsv) stellt das CSV-Exportformat des alten Terminologieservers (termpub.gv.at) dar. Das Format enthält keine Metadaten zu Codesystemen oder Value-Sets und kann nicht alle für FHIR® erforderlichen Informationen darstellen, die in anderen Dateiformaten darstellbar sind.

Für jedes Konzept können nur die folgenden Informationen in outdatedcsv dargestellt werden:
- `code`
- `codeSystem`
- `displayName`
- `parentCode` (nur Codesysteme)
- `parentCodeSystemName` (nur Value-Sets)
- `concept_Beschreibung`
- `meaning`
- `hints`
- `orderNumber` (nur Value-Sets)
- `level`
- `type`
- `relationships`
- `einheit print` (nur Value-Sets)
- `einheit codiert` (nur Value-Sets)

In Version 2 von outdatedcsv können undefinierte Attribute als zusätzliche Spalten aufgenommen werden. Darüber hinaus wurden in Version 2 die folgenden zusätzlichen Änderungen vorgenommen:
- Leere Werte sind wirklich leer und nicht mit `''` kodiert.
- Wenn am Ende einer Zeile nur leere Werte stehen, werden die `;` zwischen den bezeichneten Spalten weggelassen (CSV-konform). Dies führt zu einer Größeneinsparung von bis zu 20% bei großen Terminologien.
- Die Implementierungsempfehlung für das Lesen von CSV-Dateien lautet, die Spaltennamen und nicht den Spaltenindex zu verwenden. Hier ist ein Beispiel für einen Python-Codeausschnitt, wie dies mit einem `DictReader` aus der `csv`-Bibliothek implementiert werden kann:
```
import csv
with open(FILEPATH, 'r', newline='') as file:
  csvFile = csv.DictReader(file, quotechar='\'', delimiter=';') # DictReader allows access by keys/columns
  for csv_line in csvFile:
  ...
```