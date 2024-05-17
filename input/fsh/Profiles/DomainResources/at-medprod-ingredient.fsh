Profile:  AT_MedicinalProduct_Ingredient
Parent:   Ingredient
Id:       at-medprod-ingredient
Title:    "Ingredient"
Description: "Defines the strength and composition parts of a medicinal product"

// Active Ingredient Role - Substanzrolle (ELGA_Ingredient_role)

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

* substance.code.concept.coding[substancePharos].system = $substancePharosUrl
* substance.code.concept.coding[substanceSMS].system = $substanceSMSUrl

* substance.code.concept only AT_MedicinalProduct_CodeableConcept





// Strength - Stärke (ELGA_Ingredient_low_strength, ELGA_Ingredient_low_strength_unit)
* substance.strength 1..1
* substance.strength obeys atLeastOnePresentationOrOneConcentrationInvariant // B.R. At least one concentration or presentation

//* substance.strength.concentrationRatio 0..1 - Inherited Cardinality
//* substance.strength.concentrationRatio only EmaRatio
//* substance.strength.concentrationRatioRange 0..1 - Inherited Cardinality
//* substance.strength.concentrationRatioRange only EmaRatioRange
//* substance.strength.presentationRatio 0..1 - Inherited Cardinality
//* substance.strength.presentationRatio only EmaRatio
//* substance.strength.presentationRatioRange 0..1 - Inherited Cardinality
//* substance.strength.presentationRatioRange only EmaRatioRange

// Reference Ingredient - Referenzsubstanz (ELGA_ReferenceIngredient)
//* substance.strength.reference 0..* - Inherited Cardinality
//* substance.strength.reference.strengthRatio 1..1 - Inherited Cardinality
//* substance.strength.referenceStrength.strengthRatio only EmaRatio
//* substance.strength.reference.strengthRatioRange 0..1 - Inherited Cardinality
//* substance.strength.referenceStrength.strengthRatioRange only EmaRatioRange
//* substance.strength.referenceStrength.substance 1..1
//* substance.strength.referenceStrength.substance only CodeableReference(EmaSubstanceDefinition)

// Reference Ingredient Strength - Referenzsubstanz Stärke (ELGA_Reference_low_strength, ELGA_Reference_low_strength_unit)


