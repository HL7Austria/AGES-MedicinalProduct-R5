<table class="grid">
<tbody>
  <tr>
    <th>List of medicinal products"ASP-Liste"</th>
    <th></th>
    <th>FHIR resources</th>
    <th></th>
    <th></th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <td>Description</td>
    <td>CodeSystem</td>
    <td>PackagedProductDefinition</td>
    <td>MedicinalProductDefinition</td>
    <td>RegulatedAuthorization</td>
    <td>AdministrableProductDefinition</td>
    <td>Ingredient</td>
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
    <td>#Bezeichnung_Arzneispezialitaet_Zulassung#</td>
    <td>-</td>
    <td>.name.productName</td>
    <td>-</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Authorization number</td>
    <td>#ZulassungsNummer#</td>
    <td>-</td>
    <td>-</td>
    <td>.identifier</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Authorization state</td>
    <td>#ELGA_Zulassungsstatus#</td>
    <td>-</td>
    <td>-</td>
    <td>.status.coding</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Authorization holder</td>
    <td>#ELGA_Inhaber#</td>
    <td>-</td>
    <td>-</td>
    <td>.holder</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Validity</td>
    <td>#ELGA_Gültigkeit#</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Delivery state of the package</td>
    <td>#ELGA_MedikationPackungsstatusLieferbar#</td>
    <td>.marketingStatus.status.coding.code</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Size / Weight of the package</td>
    <td>#GroesseGewicht#</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Unit to size / weight</td>
    <td>#ELGA_MedikationMengenart_code#<br>#ELGA_MedikationMengenart_text#</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Prescription requirement state</td>
    <td>#ELGA_RezeptpflichtStatus_code#<br>#ELGA_RezeptpflichtStatus_text#</td>
    <td>-</td>
    <td>.legalStatusOfSupply.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Package type container</td>
    <td>#ELGA_Packaging_XX_code#<br>#ELGA_Packaging_XX_text#</td>
    <td>.packaging.type<br><br>TODO multiple values would have to be allowed</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Immunization target combination</td>
    <td>#ELGA_ImpfungIndikation_K_code#<br>#ELGA_ImpfungIndikation_K_text#</td>
    <td>not mapped</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Immunization target</td>
    <td>#ELGA_ImpfungIndikation_XX_code#<br>#ELGA_ImpfungIndikation_XX_text#</td>
    <td>-</td>
    <td>.classification.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Part name</td>
    <td>#ELGA_PartName#</td>
    <td>-</td>
    <td>.name.part</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>ATC code</td>
    <td>#ELGA_whoATC_XX_code#<br>#ELGA_whoATC_XX_text#</td>
    <td>-</td>
    <td>.classification.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Route of administration</td>
    <td>#ELGA_MedikationArtAnwendung_XX_code#<br>#ELGA_MedikationArtAnwendung_XX_text#</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.routeOfAdministration.code</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Substance</td>
    <td>#ELGA_Substance_XX_code#<br>#ELGA_Substance_XX_text#</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.code.concept.coding</td>
  </tr>
  <tr>
    <td>Active ingredient</td>
    <td>#ELGA_ActiveIngredient_XX_code#<br>#ELGA_ActiveIngredient_XX_text#</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.code.concept.coding</td>
  </tr>
  <tr>
    <td>Ingredient Role</td>
    <td>#ELGA_Ingredient_role_XX_text#<br></td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.role.coding</td>
  </tr>
  <tr>
    <td>Active Ingredient Strength &amp; Unit</td>
    <td>#ELGA_Ingredient_low_strength_XX#<br>#ELGA_Ingredient_low_strength_unit_XX#</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.strength</td>
  </tr>
  <tr>
    <td>Reference Ingredient</td>
    <td>#ELGA_ReferenceIngredient_XX_code#<br>#ELGA_ReferenceIngredient_XX_text#</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Reference Ingredient Strength &amp; Unit</td>
    <td>#ELGA_ReferenceIngredient_low_strengt_XX#<br>#ELGA_ReferenceIngredient_low_strength_unit_XX#</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.strength.referenceStrength</td>
  </tr>
  <tr>
    <td>Pharmaceutical dose form</td>
    <td>#ELGA_MedikationDarreichungsform_XX_code#<br>#ELGA_MedikationDarreichungsform_XX_text#</td>
    <td>-</td>
    <td>.combinedPharmaceuticalDoseForm</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Drug Interaction</td>
    <td>#ELGA_MedikationWechselwirkungsRelevant#</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Domain</td>
    <td>#Domaene#</td>
    <td>-</td>
    <td>.domain</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
</tbody>
</table>