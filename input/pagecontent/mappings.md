<table class="grid">
<tbody>
  <tr>
    <th colspan="2"><strong>List of medicinal products"ASP-Liste"</strong></th>
    <th colspan="5"><strong>FHIR resources</strong></th>
  </tr>
  <tr>
    <td><strong>Description</strong></td>
    <td><strong>CodeSystem</strong></td>
    <td><strong><a href="StructureDefinition-at-medprod-packagedProductDefinition.html">PackagedProductDefinition</a></strong></td>
    <td><strong><a href="StructureDefinition-at-medprod-medicinalProductDefinition.html">MedicinalProductDefinition</a></strong></td>
    <td><strong><a href="StructureDefinition-at-medprod-marketingRegulatedAuthorization.html">RegulatedAuthorization</a></strong></td>
    <td><strong><a href="StructureDefinition-at-medprod-administrableProductDefinition.html">AdministrableProductDefinition</a></strong></td>
    <td><strong><a href="StructureDefinition-at-medprod-ingredient.html">Ingredient</a></strong></td>
  </tr>
  <tr>
    <td>Pharmaceutical registration number<br>Pharmazentralnummer (PZN)</td>
    <td>.concept[x].code</td>
    <td>.identifier</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Trade name</td>
    <td>.concept[x].display</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td>The following are concept properties which are represented <br>by the following FHIR path:<br><br>.concept[x].property.where(code='name-of-property')<br><br>A property containing XX in its name may occur more<br>than once.</td>
    <td colspan="5"></td>
  </tr>
  <tr>
    <td>Authorization name</td>
    <td><code class="highlighter-rouge language-plaintext">Bezeichnung_Arzneispezialitaet_Zulassung</code></td>
    <td>-</td>
    <td>.name.productName</td>
    <td>-</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Authorization number</td>
    <td><code class="highlighter-rouge language-plaintext">ZulassungsNummer</code></td>
    <td>-</td>
    <td>-</td>
    <td>.identifier</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Authorization state</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Zulassungsstatus</code></td>
    <td>-</td>
    <td>-</td>
    <td>.status.coding</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Authorization holder</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Inhaber</code></td>
    <td>-</td>
    <td>-</td>
    <td>.holder</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Validity</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Gültigkeit</code></td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Delivery state of the package</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationPackungsstatusLieferbar</code></td>
    <td>.marketingStatus.status.coding.code</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Size / Weight of the package</td>
    <td><code class="highlighter-rouge language-plaintext">GroesseGewicht</code></td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Unit to size / weight</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationMengenart_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationMengenart_text</code></td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Prescription requirement state</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationRezeptpflichtStatus_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationRezeptpflichtStatus_text</code></td>
    <td>-</td>
    <td>.legalStatusOfSupply.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Package type container</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Packaging_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_Packaging_XX_text</code></td>
    <td>.packaging.type<br><br>TODO multiple values would have to be allowed</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Immunization target combination</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_K_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_K_text</code></td>
    <td>not mapped</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Immunization target</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_XX_text</code></td>
    <td>-</td>
    <td>.classification.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Part name</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_PartName</code></td>
    <td>-</td>
    <td>.name.part</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>ATC code</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_whoATC_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_whoATC_XX_text</code></td>
    <td>-</td>
    <td>.classification.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Route of administration</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationArtAnwendung_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationArtAnwendung_XX_text</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.routeOfAdministration.code</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Substance</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Substanz_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_Substanz_XX_text</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.code.concept.coding</td>
  </tr>
  <tr>
    <td>Active ingredient</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ActiveIngredient_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ActiveIngredient_XX_text</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.code.concept.coding</td>
  </tr>
  <tr>
    <td>Ingredient Role</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Ingredient_role_XX_text</code><br></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.role.coding</td>
  </tr>
  <tr>
    <td>Active Ingredient Strength &amp; Unit</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Ingredient_low_strength_XX</code><br><code class="highlighter-rouge language-plaintext">ELGA_Ingredient_low_strength_unit_XX</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.strength</td>
  </tr>
  <tr>
    <td>Reference Ingredient</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ReferenceIngredient_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ReferenceIngredient_XX_text</code></td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Reference Ingredient Strength &amp; Unit</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Reference_low_strength_XX</code><br><code class="highlighter-rouge language-plaintext">ELGA_Reference_low_strength_unit_XX</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.strength.referenceStrength</td>
  </tr>
  <tr>
    <td>Pharmaceutical dose form</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationDarreichungsform_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationDarreichungsform_XX_text</code></td>
    <td>-</td>
    <td>.combinedPharmaceuticalDoseForm</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Drug Interaction</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationWechselwirkungsRelevant</code></td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Domain</td>
    <td><code class="highlighter-rouge language-plaintext">Domaene</code></td>
    <td>-</td>
    <td>.domain</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td></td>
    <td><code class="highlighter-rouge language-plaintext">status</code></td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>