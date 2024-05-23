<div xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <blockquote class="stu-note">
    <p>Terminologies (code systems as well as value sets) within this IG whose canonicals start with the following URIs are supposed to be published on behalf of the European Medicines Agency (EMA). Currently, the code systems are availabe via <a href="https://spor.ema.europa.eu/rmswi/#/">https://spor.ema.europa.eu/rmswi/#/</a> only and are not provided as FHIR resources or as part of a FHIR IG. As soon as the EMA publishes these terminologies, this IG should be adapted accordingly.</p>
    <ul>
      <li><code class="highlighter-rouge language-plaintext">https://spor.ema.europa.eu/v1/lists/</code></li>
      <li><code class="highlighter-rouge language-plaintext">https://ema.europa.eu/fhir/vs/</code></li>
    </ul>
  </blockquote>
</div>

### Medicinal Products in Austria

This implementation guide provides the information about how regulatory information regarding medicinal products within Austria are provided by the [AGES GmbH](https://www.ages.at/).

Up until now, information related to medicinal products has been published as a single code system, namely the "ASP-Liste" ([https://termgit.elga.gv.at/CodeSystem/asp-liste](https://termgit.elga.gv.at/CodeSystem/asp-liste)). This list contained an entry for each packaged medicinal product (including those which no longer are permitted). With numerous attributes trying to capture all the information which is relevant for a medicinal product (e.g. authorization, active ingredients, etc.) the "ASP-Liste" became less and less maintainable. Furthermore, for vaccines additional properties have been added on top of the "ASP-Liste" in the code system "eImpf_Impfstoffe" ([https://termgit.elga.gv.at/CodeSystem/eimpf-impfstoffe](https://termgit.elga.gv.at/CodeSystem/eimpf-impfstoffe)). As part of the [UNICOM](https://unicom-project.eu/) project the information contained in the "ASP-Liste" has been mapped to FHIR.

### Authors and contributors

- Noel Diamant (AGES GmbH)
- Gabriel Kleinoscheg (ELGA GmbH)

### IP Statements
This document is licensed under Creative Commons "No Rights Reserved" ([CC0](https://creativecommons.org/publicdomain/zero/1.0/)).

HL7®, HEALTH LEVEL SEVEN®, FHIR® and the FHIR <img src="icon-fhir-16.png" style="float: none; margin: 0px; padding: 0px; vertical-align: bottom"/>&reg; are trademarks owned by Health Level Seven International, registered with the United States Patent and Trademark Office.

This implementation guide contains and references intellectual property owned by third parties ("Third Party IP"). Acceptance of these License Terms does not grant any rights with respect to Third Party IP. The licensee alone is responsible for identifying and obtaining any necessary licenses or authorizations to utilize Third Party IP in connection with the specification or otherwise.

{% include ip-statements.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Dependency Table

{% include dependency-table.xhtml %}

### Globals Table

{% include globals-table.xhtml %}