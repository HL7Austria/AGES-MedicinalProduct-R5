> **Für die deutsche Version bitte [hier](file_formats_de.md) klicken.**

### File Formats Overview

The following file formats are currently supported:

| Name | File extension | Character encoding | Note |
| --- | --- | --- | --- |
| FHIR® R4B xml | `.4.fhir.xml` | UTF-8 | |
| FHIR® R4B json | `.4.fhir.json` | UTF-8 | |
| fsh v1 | `.1.fsh` | UTF-8 | |
| fsh v2 | `.2.fsh` | UTF-8 | |
| propCSV v1 csv | `.1.propcsv.csv` | cp-1252 or UTF-8 if there are encoding errors | |
| propCSV v1 xlsx | `.1.propcsv.xlsx` | UTF-8 | |
| ClaML v2 | `.2.claml.xml` | UTF-8 | |
| ClaML v3 | `.3.claml.xml` | UTF-8 | |
| SVSextELGA v1 | `.1.svsextelga.xml` | UTF-8 | **Warning! DEPRECATED!**<br/>This format can technically not contain all the information<br/>that is available in the other formats.<br/>This format is only available for legacy purposes. |
| SVSextELGA v2 | `.2.svsextelga.xml`   | UTF-8 | **Warning! DEPRECATED!**<br/>This format can technically not contain all the information<br/>that is available in the other formats.<br/>This format is only available for legacy purposes. <br/>However, all concept properties are available. |
| outdatedCSV v1 | `.1.outdatedcsv.csv` | UTF-8 | **Warning! DEPRECATED!**<br/>This format can technically not contain all the information<br/>that is available in the other formats.<br/>This format is only available for legacy purposes. |
| outdatedCSV v2 | `.2.outdatedcsv.csv`  | UTF-8 | **Warning! DEPRECATED!**<br/>This format can technically not contain all the information<br/>that is available in the other formats.<br/>This format is only available for legacy purposes. <br/>However, all concept properties are available. |

### Disclaimer regarding conversion between file formats

> *Please note that the propCSV represents the core file format regarding the conversion between the various file formats. Furthermore, the XLSX version of the propCSV is fully human readable.*
>
> *E.g., if there is an element available in the FHIR® specification which is not supported in propCSV it cannot be converted to the other file formats.*

### FHIR® R4B

For the structure of FHIR® resources, please refer to the corresponding documentation, e.g.:
- [CodeSystem](http://hl7.org/fhir/R4B/codesystem.html)
- [ValueSet](http://hl7.org/fhir/R4B/valueset.html)
- [ConceptMap](http://hl7.org/fhir/R4B/conceptmap.html)

The XML representation for a resource is described using this format (see [XML Representation of Resources](http://hl7.org/fhir/R4B/xml.html)):

    <name xmlns="http://hl7.org/fhir" (attrA="value")>
      <!-- from Resource: id, meta, implicitRules, and language -->
      <nameA><!--  1..1 type description of content  --><nameA>
      <nameB[x]><!-- 0..1 type1|type1 description  --></nameB[x]>
      <nameC> <!--  1..* -->
        <nameD><!-- 1..1 type>Relevant elements  --></nameD>
      </nameC>
    <name>

The JSON representation for a resource is based on the [JSON format described in STD 90 (RFC 8259)](https://www.rfc-editor.org/info/std90), and is described using this format (see [JSON Representation of Resources](http://hl7.org/fhir/R4B/json.html)):

    {
      "resourceType" : "[Resource Type]",
      // from Source: property0
      "property1" : "<[primitive]>", // short description
      "property2" : { [Data Type] }, // short description
      "property3" : { // Short Description
        "propertyA" : { CodeableConcept }, // Short Description (Example)
      },
      "property4" : [{ // Short Description
        "propertyB" : { Reference(ResourceType) } // R!  Short Description
      }]
    }

### FHIR® Shorthand (FSH)

FHIR® Shorthand (FSH) is a domain-specific language for defining the contents of FHIR® Implementation Guides (IG). The language is specifically designed for this purpose, simple and compact, and allows the author to express their intent with fewer concerns about underlying FHIR® mechanics. FSH can be created and updated using any text editor, and because it is text, it enables distributed, team-based development using source code control tools such as GitHub.

Documentation of FSH:
- [fsh v1](http://hl7.org/fhir/uv/shorthand/2021Sep/)
- [fsh v2](http://hl7.org/fhir/uv/shorthand/)

### Proprietary CSV (propCSV) - CSV and XLSX

The proprietary CSV (propCSV) allows simplified editing of terminologies. This format is based on the FHIR® specification for code systems and value sets. It enables the documentation of metadata elements as well as concept elements of a terminology.

The FHIR® specification defines the mandatory elements for code systems (http://hl7.org/fhir/codesystem.html#resource) and value sets (http://hl7.org/fhir/valueset.html#resource). The names of the corresponding elements must not be changed. In general, no other elements than defined by the FHIR® specification may be used unless a FHIR® extension is used. However, in some exceptional cases it might be necessary to add custom elements (e.g. `parent` and `parentSystem` to support hierarchical structures in `ValueSet.expansion`) in order to support certain requirements which are still based on the FHIR® specification.

The value of an element is converted into the respective FHIR® data types (uri, identifier, string, code, ...) and stored if the conversion was successful.

The propCSV is provided as CSV as well as XLSX file. **For editing, the XLSX file is recommended.**

#### File Structure

The first two lines comprise of the metadata elements for the terminology, i.e. in the first line the name of the element is specified, in the second line the value of the corresponding element is documented.

An empty line separates the metadata elements from the concept elements.

For the concept elements a line specifying the required concept element names is followed by the respective values for each concept that shall be part of the terminology.

The metadata elements and concept elements can be specified in any order. According to the **key-value-principle** always the key is read, which gives the meaning to the value standing beneath it.

#### Code System

The following list comprises of required as well as recommended metadata elements for code systems. A sample file can be downloaded here: **[Code System](input/files/CodeSystem-cs-import-template.1.propcsv.xlsx)** *Note: cells that have to be edited are highlighted in yellow.*

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Cardinality</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>resource</code></td>
            <td><strong>1..1</strong></td>
            <td>Specifies the type of the terminology. Fixed value: <code>CodeSystem</code></td>
            <td><code>CodeSystem</code></td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td><strong>1..1</strong></td>
            <td>Logical id of this artifact.</td>
            <td><code>cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>url</code></td>
            <td><strong>1..1</strong></td>
            <td>Canonical identifier for this code system, represented as a URI (globally unique)
                (<code>Coding.system</code>).</td>
            <td><code>https://my-terminology-server.com/CodeSystem/cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>identifier</code></td>
            <td>0..*</td>
            <td>Additional identifier for the code system (business identifier). Currently, only <code>urn:oid:</code>
                is supported. As a result the value given corresponds to <code>Identifier.value</code> (see <a
                    href="http://www.hl7.org/fhir/datatypes.html#Identifier">http://www.hl7.org/fhir/datatypes.html#Identifier</a>).
            </td>
            <td><code>1.25.256.25.8.9</code></td>
        </tr>
        <tr>
            <td><code>version</code></td>
            <td><strong>1..1</strong></td>
            <td>Business version of the code system (<code>Coding.version</code>).</td>
            <td><code>1.0.0+20230601</code></td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>0..1</td>
            <td>Name for this code system (computer friendly).</td>
            <td><code>cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>title</code></td>
            <td>0..1</td>
            <td>Name for this code system (human friendly).</td>
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
            <td>Date last changed. The format is <code>YYYY-MM-DD</code>.</td>
            <td><code>2015-02-07</code></td>
        </tr>
        <tr>
            <td><code>contact</code></td>
            <td>0..*</td>
            <td>Contact details for the publisher. All sub-attributes (see <a
                    href="http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail">http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail</a>)
                are combined by a <code>|</code> in the first level and by a <code>^</code> in the second level.<br>
                <ul>
                    <li><code>name</code> - Name of an individual to contact.</li>
                    <li><code>telecom</code> - Contact details for individual or organization.<ul>
                            <li><code>system</code> - <code>phone</code> | <code>fax</code> | <code>email</code> |
                                <code>pager</code> | <code>url</code> | <code>sms</code> | <code>other</code></li>
                            <li><code>value</code> - The actual contact point details</li>
                            <li><code>use</code> - <code>home</code> | <code>work</code> | <code>temp</code> |
                                <code>old</code> | <code>mobile</code> - purpose of this contact point</li>
                            <li><code>rank</code> - Specify preferred order of use (1 = highest)</li>
                            <li><code>periodStart</code> - Starting time with inclusive boundary when the contact point
                                was/is in use.</li>
                            <li><code>periodEnd</code> - End time with inclusive boundary, if not ongoing when the
                                contact point was/is in use.</li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td><code>John Doe|url^https://my-terminology-publishing.com^^^^</code></td>
        </tr>
        <tr>
            <td><code>description</code></td>
            <td>0..1</td>
            <td>Natural language description of the code system.</td>
            <td></td>
        </tr>
        <tr>
            <td><code>copyright</code></td>
            <td>0..1</td>
            <td>Use and/or publishing restrictions.</td>
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
            <td>Total concepts in the code system</td>
            <td><code>238</code></td>
        </tr>
        <tr>
            <td><code>property</code></td>
            <td>0..*</td>
            <td>Additional information supplied about each concept. All sub-attributes are combined by a
                <code>|</code>.<br>
                <ul>
                    <li><code>code</code> <em><strong>required</strong></em> - Identifies the property on the concepts,
                        and when referred to in operations.</li>
                    <li><code>uri</code> - Formal identifier for the property</li>
                    <li><code>description</code> - Why the property is defined, and/or what it conveys</li>
                    <li><code>type</code> <em><strong>required</strong></em> - <code>code</code> | <code>Coding</code> |
                        <code>string</code> | <code>integer</code> | <code>boolean</code> | <code>dateTime</code> |
                        <code>decimal</code></li>
                </ul>
            </td>
            <td><code>child|||code</code></td>
        </tr>
    </tbody>
</table>

The following list comprises of required as well as recommended concept elements for code systems:

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Cardinality</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>code</code></td>
            <td><strong>1..1</strong></td>
            <td>Code that identifies concept.</td>
            <td><code>123456</code></td>
        </tr>
        <tr>
            <td><code>display</code></td>
            <td>0..1</td>
            <td>Text to display to the user.</td>
            <td><code>bear</code></td>
        </tr>
        <tr>
            <td><code>definition</code></td>
            <td>0..1</td>
            <td>Formal definition</td>
            <td><code>Bears are carnivoran mammals of the family Ursidae.</code></td>
        </tr>
        <tr>
            <td><code>designation</code></td>
            <td>0..*</td>
            <td>Additional representations for the concept. All sub-attributes are combined by a <code>|</code>.<br>
                <ul>
                    <li><code>language</code> - Human language of the designation.</li>
                    <li><code>use</code> - Details how this designation would be used.</li>
                    <li><code>value</code> <em><strong>required</strong></em> - The text value for this designation</li>
                </ul>
            </td>
            <td><code>de-AT|^^^^|Bär</code> or
                <code>|http://snomed.info/sct^^900000000000003001^Fully specified name^|Ursidae</code></td>
        </tr>
        <tr>
            <td><code>property</code></td>
            <td>0..*</td>
            <td>Property value for the concept. All sub-attributes are combined by a <code>|</code>.<br>
                <ul>
                    <li><code>code</code> <em><strong>required</strong></em> - Identifies the property on the concepts,
                        and when referred to in operations.</li>
                    <li><code>value</code> <em><strong>required</strong></em> - Value of the property for this concept.
                    </li>
                    <li><code>type</code> <em><strong>required</strong></em> - <code>code</code> | <code>Coding</code> |
                        <code>string</code> | <code>integer</code> | <code>boolean</code> | <code>dateTime</code> |
                        <code>decimal</code></li>
                </ul>
            </td>
            <td><code>color|brown|string</code></td>
        </tr>
    </tbody>
</table>

#### Value Set

The following list comprises of required as well as recommended metadata elements for value sets. A sample file can be downloaded here: **[Value Set](input/files/ValueSet-vs-import-template.1.propcsv.xlsx)** *Note: cells that have to be edited are highlighted in yellow.*


<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Cardinality</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>resource</code></td>
            <td><strong>1..1</strong></td>
            <td>Specifies the type of the terminology. Fixed value: <code>ValueSet</code></td>
            <td><code>ValueSet</code></td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td><strong>1..1</strong></td>
            <td>Logical id of this artifact.</td>
            <td><code>vs-import-template</code></td>
        </tr>
        <tr>
            <td><code>url</code></td>
            <td><strong>1..1</strong></td>
            <td>Canonical identifier for this value set, represented as a URI (globally unique)</td>
            <td><code>https://my-terminology-server.com/ValueSet/vs-import-template</code></td>
        </tr>
        <tr>
            <td><code>identifier</code></td>
            <td>0..*</td>
            <td>Additional identifier for the value set (business identifier). Currently, only <code>urn:oid:</code> is
                supported. As a result the value given corresponds to <code>Identifier.value</code> (see <a
                    href="http://www.hl7.org/fhir/datatypes.html#Identifier">http://www.hl7.org/fhir/datatypes.html#Identifier</a>).
            </td>
            <td><code>1.2.3.4.5.6.7.9.10</code></td>
        </tr>
        <tr>
            <td><code>version</code></td>
            <td><strong>1..1</strong></td>
            <td>Business version of the value set.</td>
            <td><code>1.0.0+20230601</code></td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>0..1</td>
            <td>Name for this value set (computer friendly).</td>
            <td><code>vs-import-template</code></td>
        </tr>
        <tr>
            <td><code>title</code></td>
            <td>0..1</td>
            <td>Name for this value set (human friendly).</td>
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
            <td>Date last changed. The format is <code>YYYY-MM-DD</code>.</td>
            <td><code>2015-02-07</code></td>
        </tr>
        <tr>
            <td><code>contact</code></td>
            <td>0..*</td>
            <td>Contact details for the publisher. All sub-attributes (see <a
                    href="http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail">http://hl7.org/fhir/R4B/metadatatypes.html#ContactDetail</a>)
                are combined by a <code>|</code> in the first level and by a <code>^</code> in the second level.<br>
                <ul>
                    <li><code>name</code> - Name of an individual to contact.</li>
                    <li><code>telecom</code> - Contact details for individual or organization.<ul>
                            <li><code>system</code> - <code>phone</code> | <code>fax</code> | <code>email</code> |
                                <code>pager</code> | <code>url</code> | <code>sms</code> | <code>other</code></li>
                            <li><code>value</code> - The actual contact point details</li>
                            <li><code>use</code> - <code>home</code> | <code>work</code> | <code>temp</code> |
                                <code>old</code> | <code>mobile</code> - purpose of this contact point</li>
                            <li><code>rank</code> - Specify preferred order of use (1 = highest)</li>
                            <li><code>periodStart</code> - Starting time with inclusive boundary when the contact point
                                was/is in use.</li>
                            <li><code>periodEnd</code> - End time with inclusive boundary, if not ongoing when the
                                contact point was/is in use.</li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td><code>John Doe|url^https://my-terminology-publishing.com^^^^</code></td>
        </tr>
        <tr>
            <td><code>description</code></td>
            <td>0..1</td>
            <td>Natural language description of the value set.</td>
            <td></td>
        </tr>
        <tr>
            <td><code>copyright</code></td>
            <td>0..1</td>
            <td>Use and/or publishing restrictions.</td>
            <td></td>
        </tr>
    </tbody>
</table>

The following list comprises of required as well as recommended concept elements for value sets:

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Cardinality</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>system</code></td>
            <td><strong>1..1</strong></td>
            <td>The code system the codes come from.</td>
            <td><code>https://my-terminology-server.com/CodeSystem/cs-import-template</code></td>
        </tr>
        <tr>
            <td><code>version</code></td>
            <td>0..1</td>
            <td>Specific version of the code system referred to.</td>
            <td><code>1.0.0+20230601</code></td>
        </tr>
        <tr>
            <td><code>code</code></td>
            <td><strong>1..1</strong></td>
            <td>Code or expression from system</td>
            <td><code>123456</code></td>
        </tr>
        <tr>
            <td><code>display</code></td>
            <td>0..1</td>
            <td>Text to display for this code in this value set.</td>
            <td><code>bear</code></td>
        </tr>
        <tr>
            <td><code>designation</code></td>
            <td>0..*</td>
            <td>Additional representations for the concept. All sub-attributes are combined by a <code>|</code>.<br>
                <ul>
                    <li><code>language</code> - Human language of the designation.</li>
                    <li><code>use</code> - Details how this designation would be used.</li>
                    <li><code>value</code> <em><strong>required</strong></em> - The text value for this designation</li>
                </ul>
            </td>
            <td><code>de-AT|^^^^|Bär</code> or
                <code>|http://snomed.info/sct^^900000000000003001^Fully specified name^|Ursidae</code></td>
        </tr>
        <tr>
            <td><code>exclude</code></td>
            <td>0..1</td>
            <td>As the opposite of include, this allows to explicitly exclude a specific concept of a code system. Even
                whole code systems or value sets, with all their concepts, may be excluded. Additionally, code system
                filters can be used in order to exclude multiple concepts based on their properties. <code>true</code>
                if the line within the propCSV shall be interpreted as an exclusion. If not specified
                <code>false</code> is assumed, i.e. the line will be interpreted as inclusion.<br/><br/><em>Note: At
                least one line must represent an inclusion.</em></td>
            <td><code>true</code></td>
        </tr>
        <tr>
            <td><code>parent</code></td>
            <td>0..1</td>
            <td>Code of the parent of this concept. Combined with <code>parentSystem</code> this element is necessary
                when dealing with hierarchical value sets. In a FHIR® ValueSet this will then result in a hierarchical
                expansion, i.e. <code>ValueSet.expansion.contains.contains</code>.</td>
            <td><code>123457</code></td>
        </tr>
        <tr>
            <td><code>parentSystem</code></td>
            <td>0..1</td>
            <td>Code system of the parent's code of this concept. Required if <code>parent</code> is used.</td>
            <td><code>https://my-terminology-server.com/CodeSystem/cs-import-template</code></td>
        </tr>
    </tbody>
</table>

### ClaML v2 and v3

ClaML (Classification Markup Language) is a special XML data format for classifications. The ClaML file format primarily supports code systems.

The following elements describe the metadata of a terminology:

| Element | Description |
| --- | --- |
| `Title` | Contains the name (`name` attribute), the version (`version` attribute) as well as the validity date (`date` attribute, format: `YYYY-MM-DD`). |
| `Identifier` | Contains the OID of the terminology within the `uid` attribute. |
| `Authors` | Contains one or more `Author` elements which contain the name (`name` attribute) of the author and the contact details as element content. |
| `Meta` | Several `Meta` elements contain furter information as key-value pairs. |

The most used `Meta` elements are:
- `titleLong` - Human readable title
- `resource` - Specifies the type of the terminology (e.g. `CodeSystem`, `ValueSet`)
- `id` - Logical id of this artifact
- `url` - Canonical identifier for this terminology, represented as a URI (globally unique)
- `status` - `draft` \| `active` \| `retired` \| `unknown`
- `description` - German description of the terminology
- `description_eng` - English description of the terminology
- `content` - Relevant for code systems only. `not-present` \| `example` \| `fragment` \| `complete` \| `supplement`
- `website` - Link to source etc.
- `copyright` - Use and/or publishing restrictions.
- `version_description` - Description of the version
- `property` - Declares the properties which are to be expected within the concepts of this terminology

The concepts are represented as `Class` elements:
- `Class/@code` - Code of the concept
- `Class/Rubric[@kind='preferred']` - Display of the concept
- `Class/Rubric[@kind='note']` - more detailed description (application description) of the concept
- `Class/Meta[@name='TS_ATTRIBUTE_HINTS']` - hints on the application of the concept
- `Class/Meta[@name='TS_ATTRIBUTE_MEANING']` or `Class/Rubric[@kind='designation']` with `de-AT` - German language variant
- `Class/Meta[@name='Level']` and `Class/Meta[@name='Type']` - mapping of the hierarchy
- `Class/SubClass` - specifies the child concepts of this concept
- `Class/SuperClass` - specifies the parent concepts of this concept

### SVSextELGA v1 and v2

> ***DISCLAIMER:*** This file format is **deprecated**. The SVSextELGA will continue to be supported for the time being. However, no further developments for this format will be implemented. As a result, this file format can technically not contain all the information that is available in non-deprecated file formats. Furthermore, in the medium term (approx. 2025), this format will be fully removed.

The supported SVS is based on the IHE Sharing Value Set format and has been extended for ELGA purposes. This XML format supports code systems as well as value sets.

The root element `valueSet` contains the metadata of the terminology as attributes:
- `name` - name of the terminology
- `displayName` - human readable name of the terminology
- `beschreibung` - description of the terminology in German
- `description` - description of the terminology in English
- `effectiveDate` - validity date
- `id` - OID of the terminology
- `last_change_date` - date last changed
- `version` - version of the terminology
- `website` - Link to source etc.

The `conceptList` element contains the concepts represented as `concept` elements. The following list explains the most important attributes of the `concept` element:
- `code` - Code that identifies concept
- `displayName` - Text to display for this code in this value set
- `displayNameAlt` - Alternative display name
- `codeSystem` - OID of the code system the code comes from
- `concept_beschreibung` - more detailed description (application description) of the concept
- `deutsch` - German language variant, meaning
- `einheit_codiert` - coded representation of a test result's unit
- `einheit_print` - human readable form of a test result's unit
- `hinweise` - Notes regarding the application of the concept
- `level` - specifies the level of the concept within a hierarchy
- `orderNumber` - index to fix the order of concepts (relevant only for value sets)
- `parentCodeSystemName` - canonical url of the code system the code comes from
- `relationships` - possible connections to other concepts
- `type` - type of the concept (`L` - leaf, `S` - specializable, `A` - abstract, `D` - deprecated)

In version 2 of SVSextELGA, undefined attributes/properties may be included as additional concept attributes.

### Outdated CSV (outdatedcsv) v1 and v2

> ***DISCLAIMER:*** This file format is **deprecated**. The outdatedcsv will continue to be supported for the time being. However, no further developments for this format will be implemented. As a result, this file format can technically not contain all the information that is available in non-deprecated file formats. Furthermore, in the medium term (approx. 2025), this format will be fully removed.

The outdated CSV (outdatedcsv) represents the CSV export format of the old terminology server (termpub.gv.at). The format does not contain any metadata on code systems or value sets and cannot represent all the information required for FHIR® that is representable in other file formats.

For each concept only the following information can be represented in outdatedcsv:
- `code`
- `codeSystem`
- `displayName`
- `parentCode` (code systems only)
- `parentCodeSystemName` (value sets only)
- `concept_Beschreibung`
- `meaning`
- `hints`
- `orderNumber` (value sets only)
- `level`
- `type`
- `relationships`
- `einheit print` (value sets only)
- `einheit codiert` (value sets only)

In version 2 of outdatedcsv, undefined attributes may be included as additional columns. Furthermore, the following additional changes have been implemented in version 2:
- Empty values are really empty and not coded with `''`
- If there are only empty values at the end of a line, the `;` between the designated columns are omitted (CSV compliant). This results in size savings of up to 20% for large terminologies.
- The implementation recommendation for reading CSVs is to use the column names and not the column index. Here is an example Python code snippet how this can be done with a `DictReader` from the `csv` library:
```
import csv
with open(FILEPATH, 'r', newline='') as file:
  csvFile = csv.DictReader(file, quotechar='\'', delimiter=';') # DictReader allows access by keys/columns
  for csv_line in csvFile:
  ...
```