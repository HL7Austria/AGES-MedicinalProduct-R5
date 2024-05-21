Profile:  AT_MedicinalProduct_PackagedProductDefinition
Parent:   PackagedProductDefinition
Id:       at-medprod-packagedproductdefinition
Title:    "Packaged product definition"
Description: "Defines the package information of a medicinal product"

* id 1..1
* packageFor 1..1
* packageFor only Reference(AT_MedicinalProduct_MedicinalProductDefinition)



// PZN
* identifier 1..1
* identifier only AT_MedicinalProduct_Identifier
* identifier.system = $PZNUrl

// Delivery State of the package - Status der Packung

// Size / Weight of the package - Packungsgröße + Unit
* containedItemQuantity 1..1 // According to the EU IG it should be 1..*
* containedItemQuantity.value 1..1
* containedItemQuantity.unit 0..1
* containedItemQuantity.code 1..1
* containedItemQuantity.code from UnitsOfPresentationVs (required) // TODO: It's a string, it might not work
* containedItemQuantity.system 1..1
* containedItemQuantity.system = $unitsOfPresentationUrl // TODO: There might be a different way of doing this (even though containedItemQuantity isn't a coding).


// Package type container - Primärverpackung

// Package items

* description 1..1
