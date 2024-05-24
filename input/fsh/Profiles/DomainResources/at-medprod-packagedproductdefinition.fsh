Profile:  AT_MedicinalProduct_PackagedProductDefinition
Parent:   PackagedProductDefinition
Id:       at-medprod-packagedProductDefinition
Title:    "Packaged product definition"
Description: "Defines the package information of a medicinal product"

// ID = PZN

* packageFor 1..1
* packageFor only Reference(AT_MedicinalProduct_MedicinalProductDefinition)

// PZN
* identifier ^short = "A unique identifier for this package as whole - not for the content of the package (pharmaceutical registration number (Pharmazentralnummer (PZN)))"
* identifier 1..1
* identifier only AT_MedicinalProduct_Identifier
* identifier.system = $PZNUrl

// Delivery State of the package - Status der Packung
* marketingStatus ^short = "Allows specifying that an item is on the market for sale, or that it is not available, and the dates and locations associated (delivery state of the package)"
* marketingStatus 1..1
* marketingStatus.status only AT_MedicinalProduct_CodeableConcept
* marketingStatus.status from MarketingStatusVs


// Size / Weight of the package - Packungsgröße + Unit
* containedItemQuantity ^short = "A total of the complete count of contained items of a particular type/form, independent of sub-packaging or organization. This can be considered as the pack size. See also packaging.containedItem.amount (size / weight of the package)"
* containedItemQuantity 1..1 // According to the EU IG it should be 1..*
* containedItemQuantity.value 1..1
* containedItemQuantity.code 1..1
* containedItemQuantity.code from UnitsOfPresentationVs (required)
* containedItemQuantity.system 1..1

// Package type container - Primärverpackung
* packaging.type ^short = "The physical type of the container of the items (package type container)"
* packaging.type only AT_MedicinalProduct_CodeableConcept
* packaging.type from PackagingVs
