The following table maps all relevant fields and attributes of the "ASP-Liste" ([https://termgit.elga.gv.at/CodeSystem/asp-liste](https://termgit.elga.gv.at/CodeSystem/asp-liste)) and the "eImpf_Impfstoffe" ([https://termgit.elga.gv.at/CodeSystem/eimpf-impfstoffe](https://termgit.elga.gv.at/CodeSystem/eimpf-impfstoffe)) to FHIR resources.

<table class="grid">
<tbody>
  <tr>
    <th colspan="2"><strong>List of medicinal products ("ASP-Liste" or "eImpf_Impfstoffe")</strong></th>
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
    <td><code class="highlighter-rouge language-plaintext">.concept[x].code</code></td>
    <td><code class="highlighter-rouge language-plaintext">.identifier</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Trade name</td>
    <td><code class="highlighter-rouge language-plaintext">.concept[x].display</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.name.part.where(type.coding.code='tradeName')</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td></td>
    <td>The following are concept properties which are represented <br>by the following FHIR path:<br><br><code class="highlighter-rouge language-plaintext">.concept[x].property.where(code='name-of-property')</code><br><br>A property containing XX in its name may occur more<br>than once.</td>
    <td colspan="5"></td>
  </tr>
  <tr>
    <td>Authorization name</td>
    <td><code class="highlighter-rouge language-plaintext">Bezeichnung_Arzneispezialitaet_Zulassung</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.name.productName</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Authorization number</td>
    <td><code class="highlighter-rouge language-plaintext">ZulassungsNummer</code></td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.identifier</code></td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Authorization state</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Zulassungsstatus</code></td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.status.coding</code></td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Authorization holder</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Inhaber</code></td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.holder</code></td>
    <td>-</td>
    <td>-</td>
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
    <td><code class="highlighter-rouge language-plaintext">.marketingStatus.status.coding.code</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Size / Weight of the package</td>
    <td><code class="highlighter-rouge language-plaintext">GroesseGewicht</code></td>
    <td><code class="highlighter-rouge language-plaintext">.containedItemQuantity.value</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Unit to size / weight</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationMengenart_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationMengenart_text</code></td>
    <td><code class="highlighter-rouge language-plaintext">.containedItemQuantity.code<br/>.containedItemQuantity.unit</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Prescription requirement state</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationRezeptpflichtStatus_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationRezeptpflichtStatus_text</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.legalStatusOfSupply.coding</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Package type container</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Packaging_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_Packaging_XX_text</code></td>
    <td><code class="highlighter-rouge language-plaintext">.packaging.type</code><br> Additional <code class="highlighter-rouge language-plaintext">.packaging.type</code> can be added in additional packagagings via the self reference <code class="highlighter-rouge language-plaintext">.packaging.packaging</code>.</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Immunization target combination</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_K_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_K_text</code></td>
    <td colspan="5"><i>not mapped</i></td>
  </tr>
  <tr>
    <td>Immunization target</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ImpfungIndikation_XX_text</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.classification.coding.where(system=<br/>
    'https://termgit.elga.gv.at/CodeSystem/eimpf-ergaenzung')</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Part name</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_PartName</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.name.part.where(type.coding.code=<br/>'220000000002')</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>ATC code</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_whoATC_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_whoATC_XX_text</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.classification.coding.where(system=<br/>'http://www.whocc.no/atc')</code></td>
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
    <td><code class="highlighter-rouge language-plaintext">.routeOfAdministration.code</code></td>
    <td>-</td>
  </tr>
  <tr>
    <td>Substance</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Substanz_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_Substanz_XX_text</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.substance.code.concept.coding.where(system='https://www.ages.at/fhir/GRZ')</code></td>
  </tr>
  <tr>
    <td>Active ingredient</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ActiveIngredient_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ActiveIngredient_XX_text</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.substance.code.concept.coding.where(system='https://spor.ema.europa.eu/v3/SubstanceDefinition')</code></td>
  </tr>
  <tr>
    <td>Ingredient Role</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Ingredient_role_XX_text</code><br></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.role.coding</code></td>
  </tr>
  <tr>
    <td>Active Ingredient Strength &amp; Unit</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Ingredient_low_strength_XX</code><br><code class="highlighter-rouge language-plaintext">ELGA_Ingredient_low_strength_unit_XX</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.substance.strength</code></td>
  </tr>
  <tr>
    <td>Reference Ingredient</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_ReferenceIngredient_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_ReferenceIngredient_XX_text</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.substance.strength.referenceStrength.substance</code></td>
  </tr>
  <tr>
    <td>Reference Ingredient Strength &amp; Unit</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_Reference_low_strength_XX</code><br><code class="highlighter-rouge language-plaintext">ELGA_Reference_low_strength_unit_XX</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.substance.strength.referenceStrength.strength[x]</code></td>
  </tr>
  <tr>
    <td>Pharmaceutical dose form</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationDarreichungsform_XX_code</code><br><code class="highlighter-rouge language-plaintext">ELGA_MedikationDarreichungsform_XX_text</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.combinedPharmaceuticalDoseForm</code></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Drug Interaction</td>
    <td><code class="highlighter-rouge language-plaintext">ELGA_MedikationWechselwirkungsRelevant</code></td>
    <td></td>
    <td><code class="highlighter-rouge language-plaintext">.classification.coding.where(system=<br/>'https://www.ages.at/fhir/interactionRelevance')</code></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Domain</td>
    <td><code class="highlighter-rouge language-plaintext">Domaene</code></td>
    <td>-</td>
    <td><code class="highlighter-rouge language-plaintext">.domain</code></td>
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