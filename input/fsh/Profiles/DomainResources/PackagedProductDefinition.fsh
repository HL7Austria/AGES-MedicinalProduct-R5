Profile:  PackagedProductDefinition
Parent:   PackagedProductDefinitionRestrictions
Id:       PackagedProductDefinition
Title:    "Packaged product definition"
Description: "Defines the Package information of a Medicinal Product"

* id 1..1

// PZN
* identifier 1..1
* identifier.system = "$PZNUrl"

// Delivery State of the package - Status der Packung

// Size / Weight of the package - Packungsgröße + Unit

// Package type container - Primärverpackung




* packageFor 1..1
* packageFor only Reference(EmaMedicinalProductDefinition)

* containedItemQuantity 1..1 // TODO: According to the excel it should be 1..*
* containedItemQuantity.value 1..1
* containedItemQuantity.unit 0..1
* containedItemQuantity.code 1..1
* containedItemQuantity.code from UnitsOfPresentationVs (required) // TODO: It's a string, it might not work
* containedItemQuantity.system 1..1
* containedItemQuantity.system = $unitsOfPresentationUrl // TODO: There might be a different way of doing this (even though containedItemQuantity isn't a coding).

* description 1..1

//* manufacturer 0..* - Inherited Cardinality
* manufacturer.extension.valueReference only Reference(EmaActivityDefinition)

// The Package backbone (its recursive nature is defined in EmaRecursivePackage).
* .packaging 1..1 // The '* .' dot defines it exclusively at the root level. // B.R. T35.
* packaging.identifier 1..1
* packaging.identifier only EmaDataCarrierIdentifier
* packaging.type only EmaRefTermCodeableConcept
* packaging.type from PackagingVs
* packaging.quantity 1..1
* packaging.shelfLifeStorage 0..*
* packaging.shelfLifeStorage.type 1..1
* packaging.shelfLifeStorage.type only EmaRefTermCodeableConcept
* packaging.shelfLifeStorage.type from ShelfLifeTypeVs
* packaging.shelfLifeStorage.specialPrecautionsForStorage 0..*
* packaging.shelfLifeStorage.specialPrecautionsForStorage only EmaRefTermCodeableConcept
* packaging.shelfLifeStorage.specialPrecautionsForStorage from SpecialPrecautionsForStorageVs
* packaging.shelfLifeStorage.period[x] 1..1
* packaging.shelfLifeStorage.period[x] only EmaDuration
* packaging.material 1..*
* packaging.material only emaRefTermCodeableConcept
* packaging.material from MaterialVs
* packaging.containedItem 0..*

* packaging.containedItem.item only CodeableReference(EmaDeviceDefinition or EmaManufacturedItemDefinition)
