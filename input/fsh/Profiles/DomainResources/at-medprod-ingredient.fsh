Profile:  AT_MedicinalProduct_Ingredient
Parent:   Ingredient
Id:       at-medprod-ingredient
Title:    "Ingredient"
Description: "Defines the strength and composition parts of a medicinal product"

* for 1..1

// ID Ingredient GRZ

// * for only Reference(http://hl7.org/fhir/StructureDefinition/ManufacturedItemDefinition)

// Active Ingredient Role - Substanzrolle (ELGA_Ingredient_role)
* role ^short = "Ingredient role"
* role only AT_MedicinalProduct_CodeableConcept
* role from IngredientRoleVs
* role = IngredientRoleCs#100000072072

// Substance
* substance.code.concept 1..1
* substance.code.concept.coding ^slicing.discriminator.type = #value
* substance.code.concept.coding ^slicing.discriminator.path = "system"
* substance.code.concept.coding ^slicing.description = "Slice differentiating SMS and Pharos Substance Ids"
* substance.code.concept.coding ^slicing.ordered = false
* substance.code.concept.coding ^slicing.rules = #open
* substance.code.concept.coding contains
substancePharos 1..1 // Substance Code Pharos - Deutsch (ELGA_Substanz)
and substanceSMS 0..1 // Substance Code SMS - English (ELGA_ActiveIngredient)

* substance.code.concept.coding[substancePharos].system ^short = "Substance"
* substance.code.concept.coding[substancePharos].system = $substancePharosUrl
* substance.code.concept.coding[substanceSMS].system ^short = "Active ingredient"
* substance.code.concept.coding[substanceSMS].system = $substanceSMSUrl

* substance.code.concept only AT_MedicinalProduct_CodeableConcept

// Strength - Stärke (ELGA_Ingredient_low_strength, ELGA_Ingredient_low_strength_unit)
* substance.strength ^short = "Active ingredient strength & unit"
* substance.strength 1..1
* substance.strength obeys atLeastOnePresentationOrOneConcentrationInvariant // B.R. At least one concentration or presentation

// Reference Ingredient Strength - Referenzsubstanz Stärke (ELGA_Reference_low_strength, ELGA_Reference_low_strength_unit)
* substance.strength.referenceStrength.substance ^short = "Reference ingredient"
* substance.strength.referenceStrength.strength[x] ^short = "Reference ingredient strength & unit"