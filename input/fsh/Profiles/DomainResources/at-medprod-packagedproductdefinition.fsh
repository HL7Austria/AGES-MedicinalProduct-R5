Profile:  AT_MedicinalProduct_PackagedProductDefinition
Parent:   PackagedProductDefinition
Id:       at-medprod-packagedproductdefinition
Title:    "Packaged product definition"
Description: "Defines the package information of a medicinal product"

* packageFor 1..1
* packageFor only Reference(AT_MedicinalProduct_MedicinalProductDefinition)

// ID & PZN
* identifier ^short = "A unique identifier for this package as whole - not for the content of the package (pharmaceutical registration number (Pharmazentralnummer (PZN)))"
* identifier only AT_MedicinalProduct_Identifier

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "The package has the ID PZN as well as a Pharos ID from the Austrian Agency"
* identifier ^slicing.ordered = false
* identifier contains
    PZN 1..1 and
    referenceNumber 1..1
* identifier[referenceNumber].system = $GRZ
* identifier[PZN].system = $PZNUrl



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

// Size / Weight of the contained item
* packaging.containedItem.amount ^short = "The amount of the manufactured Item inside this packaging (E.g. Number of ml in a bottle). Not to be mistaken with the .containedItemQuantity which is the total presentable items in the package."
* packaging.containedItem.amount.value 1..1
* packaging.containedItem.amount.unit 1..1
* packaging.containedItem.amount.system 1..1
* packaging.containedItem.amount.code 1..1
* packaging.containedItem.amount.code from UnitsOfMeasurementVs

// Package type container - Primärverpackung
* packaging.type ^short = "The physical type of the container of the items (package type container) (Presentation List)"
* packaging.type only AT_MedicinalProduct_CodeableConcept
* packaging.type from PackagingVs

// Second container
* packaging.packaging ^short = "In order to add more package types, additional packagings must be added first with a reference to the packaging it is included in. "
