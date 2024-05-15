Profile:  Ingredient
Parent:   IngredientRestrictions
Id:       Ingredient
Title:    "ingredient"
Description: "Defines the Strength and Composition parts of a medicinal product"

// Active Ingredient - Rolle (ELGA_Ingredient_role)

// Substance Code Pharos - Deutsch (ELGA_Substanz)
* substance.code.concept 1..1
* substance.code.concept.coding.system 1..1
* substance.code.concept.coding.system = $substanceDefinitionUrl
* substance.code.concept.coding.code 1..1
* substance.code.concept.coding.display 1..1


// Substance Code SMS - English (ELGA_ActiveIngredient)

// Strength - Stärke (ELGA_Ingredient_low_strength, ELGA_Ingredient_low_strength_unit)
* substance.strength 1..1
* substance.strength obeys atLeastOnePresentationOrOneConcentrationInvariant // B.R. At least one concentration or presentation

//* substance.strength.concentrationRatio 0..1 - Inherited Cardinality
* substance.strength.concentrationRatio only EmaRatio
//* substance.strength.concentrationRatioRange 0..1 - Inherited Cardinality
* substance.strength.concentrationRatioRange only EmaRatioRange
//* substance.strength.presentationRatio 0..1 - Inherited Cardinality
* substance.strength.presentationRatio only EmaRatio
//* substance.strength.presentationRatioRange 0..1 - Inherited Cardinality
* substance.strength.presentationRatioRange only EmaRatioRange

// Reference Ingredient - Referenzsubstanz (ELGA_ReferenceIngredient)
//* substance.strength.reference 0..* - Inherited Cardinality
//* substance.strength.reference.strengthRatio 1..1 - Inherited Cardinality
* substance.strength.referenceStrength.strengthRatio only EmaRatio
//* substance.strength.reference.strengthRatioRange 0..1 - Inherited Cardinality
* substance.strength.referenceStrength.strengthRatioRange only EmaRatioRange
* substance.strength.referenceStrength.substance 1..1
* substance.strength.referenceStrength.substance only CodeableReference(EmaSubstanceDefinition)

// Reference Ingredient Strength - Referenzsubstanz Stärke (ELGA_Reference_low_strength, ELGA_Reference_low_strength_unit)


