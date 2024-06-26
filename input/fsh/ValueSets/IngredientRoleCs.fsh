CodeSystem: IngredientRoleCs
Id: 100000072050
Title: "Ingredient Role"
Description:  "Ingredient Role"
// The line below overrides the canonical URL (which is the default).
* ^url = "https://spor.ema.europa.eu/v1/lists/100000072050"
* ^status = #active
* ^version = "5.0.0" // should represent the version of the code system not the FHIR version
* ^experimental = false
* ^publisher = "European Medicines Agency"
//* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America" //TODO - get this code
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
* #100000072072 "Active"
* #100000072073 "Adjuvant"
* #100000072082 "Excipient"
* #100000136066 "Solvent / Diluent"