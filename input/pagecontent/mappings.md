<table class="grid">
<tbody>
  <tr>
    <th>"ASP-Liste"</th>
    <th></th>
    <th></th>
    <th>FHIR resources</th>
    <th></th>
    <th></th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <td>Name (german)</td>
    <td>Description</td>
    <td>XML tag or attribute based on ClaML v2</td>
    <td>PackagedProductDefinition</td>
    <td>MedicinalProductDefinition</td>
    <td>RegulatedAuthorization</td>
    <td>AdministrableProductDefinition</td>
    <td>Ingredient</td>
  </tr>
  <tr>
    <td>Pharmazentralnummer (PZN)</td>
    <td>Pharmaceutical registration number as record ID</td>
    <td>&lt;Class code="xxxx"&gt;</td>
    <td>.identifier</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Handelsname (Kurztext vom APO Verlag)</td>
    <td>Trade name</td>
    <td>&lt;Label&gt;xxxx&lt;/Label&gt;</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Zulassungsname</td>
    <td>Authorization name</td>
    <td>&lt;Meta name="Bezeichnung_Arzneispezialitaet_Zulassung" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>.name.productName</td>
    <td>-</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Zulassungsnummer</td>
    <td>Authorization number</td>
    <td>&amp;lt;Meta name="ZulassungsNummer" value="xxxx"/&amp;gt;</td>
    <td>-</td>
    <td>-</td>
    <td>.identifier</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Zulassungsstatus</td>
    <td>Authorization state</td>
    <td>&lt;Meta name="ELGA_Zulassungsstatus" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>-</td>
    <td>.status.coding</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>Zulassungsinhaber</td>
    <td>Authorization holder</td>
    <td>&lt;Meta name="ELGA_Inhaber" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>-</td>
    <td>.holder</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>ELGA Gültigkeit</td>
    <td>Validity</td>
    <td>&lt;Meta name="ELGA_Gültigkeit" value="xxxx"/&gt;</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Status der Packung</td>
    <td>Delivery state of the package</td>
    <td>&lt;Meta name="ELGA_MedikationPackungsstatusLieferbar" value="xxxx"/&gt;</td>
    <td>.marketingStatus.status.coding.code</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Menge (Packungsgröße)</td>
    <td>Size / Weight of the package</td>
    <td>&lt;Meta name="GroesseGewicht" value="xxxx"/&gt;</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Mengenart</td>
    <td>Unit to size / weight</td>
    <td>&amp;lt;Meta name="ELGA_MedikationMengenart_code" value="xxxx"/&amp;gt;<br>&amp;lt;Meta name="ELGA_MedikationMengenart_text" value="xxxx"/&amp;gt;</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Rezeptpflichtstatus</td>
    <td>Prescription requirement state</td>
    <td>&amp;lt;Meta name="ELGA_RezeptpflichtStatus_code" value="xxxx"/&amp;gt;<br>&amp;lt;Meta name="ELGA_RezeptpflichtStatus_text" value="xxxx"/&amp;gt;</td>
    <td>-</td>
    <td>.legalStatusOfSupply.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Primärverpackung</td>
    <td>Package type container</td>
    <td>&lt;Meta name="ELGA_Packaging_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_Packaging_XX_text" value="xxxx"/&gt;</td>
    <td>.packaging.type<br><br>TODO multiple values would have to be allowed</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Kombinationsimpfungen</td>
    <td>Immunization target combination</td>
    <td>&lt;Meta name="ELGA_ImpfungIndikation_K_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_ImpfungIndikation_K_text" value="xxxx"/&gt;</td>
    <td>not mapped</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Impfziel</td>
    <td>Immunization target</td>
    <td>&lt;Meta name="ELGA_ImpfungIndikation_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_ImpfungIndikation_XX_text" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>.classification.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>PartName</td>
    <td>Part name</td>
    <td>&lt;Meta name="ELGA_PartName" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>.name.part</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>ATC Code</td>
    <td>ATC code</td>
    <td>&lt;Meta name="ELGA_whoATC_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_whoATC_XX_text" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>.classification.coding</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Art der Anwendung</td>
    <td>Route of administration</td>
    <td>&amp;lt;Meta name="ELGA_MedikationArtAnwendung_XX_code" value="xxxx"/&amp;gt;<br>&amp;lt;Meta name="ELGA_MedikationArtAnwendung_XX_text" value="xxxx"/&amp;gt;</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.routeOfAdministration.code</td>
    <td>-</td>
  </tr>
  <tr>
    <td>Substanz</td>
    <td>Substance</td>
    <td>&lt;Meta name="ELGA_Substance_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_Substance_XX_text" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.code.concept.coding</td>
  </tr>
  <tr>
    <td>Activtive Ingredient</td>
    <td>Active ingredient</td>
    <td>&lt;Meta name="ELGA_ActiveIngredient_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_ActiveIngredient_XX_text" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.code.concept.coding</td>
  </tr>
  <tr>
    <td>Ingredient Role</td>
    <td></td>
    <td>&lt;Meta name="ELGA_Ingredient_role_XX_text" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.role.coding</td>
  </tr>
  <tr>
    <td>Active Ingredient Strength &amp; Unit</td>
    <td></td>
    <td>&amp;lt;Meta name="ELGA_Ingredient_low_strength_XX" value="xxxx/&amp;gt;<br>&amp;lt;Meta name="ELGA_Ingredient_low_strength_unit_XX" value="xxxx"/&amp;gt;</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.strength</td>
  </tr>
  <tr>
    <td>Reference Ingredient</td>
    <td></td>
    <td>&lt;Meta name="ELGA_ReferenceIngredient_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_ReferenceIngredient_XX_text" value="xxxx"/&gt;</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Reference Ingredient Strength &amp; Unit</td>
    <td></td>
    <td>&lt;Meta name="ELGA_ReferenceIngredient_low_strength_XX" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_ReferenceIngredient_low_strength_unit_XX" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>.substance.strength.referenceStrength</td>
  </tr>
  <tr>
    <td>Darreichungsform</td>
    <td>Pharmaceutical dose form</td>
    <td>&lt;Meta name="ELGA_MedikationDarreichungsform_XX_code" value="xxxx"/&gt;<br>&lt;Meta name="ELGA_MedikationDarreichungsform_XX_text" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>.combinedPharmaceuticalDoseForm</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  <tr>
    <td>ELGA Wechselwirkung</td>
    <td>Drug Interaction</td>
    <td>&lt;Meta name="ELGA_MedikationWechselwirkungsRelevant" value="xxxx"/&gt;</td>
    <td>TODO</td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Domäne</td>
    <td>Domain</td>
    <td>&lt;Meta name="Domaene" value="xxxx"/&gt;</td>
    <td>-</td>
    <td>.domain</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
</tbody>
</table>