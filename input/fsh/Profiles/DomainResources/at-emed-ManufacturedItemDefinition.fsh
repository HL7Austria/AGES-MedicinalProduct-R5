Profile:  at-emed-ManufacturedItemDefinition
Parent:   ManufacturedItemDefinition
Id:       at-emed-ManufacturedItemDefinition
Title:    "Manufactured item definition"
Description: "Manufactured Items are required to maintain the link between Ingredient and Packaged Medicinal Product"

// Shortcut could be maintained
//* extension 1..1
//* extension only SubjectExtension

//* status 1..1 - Inherited Cardinality
* status = #"active"

//* manufacturedDoseForm 1..1 - Inherited Cardinality
* manufacturedDoseForm only RefTermCodeableConcept
* manufacturedDoseForm from PharmaceuticalDoseFormVs

//* unitOfPresentation 0..1 - Inherited Cardinality
* unitOfPresentation only RefTermCodeableConcept
* unitOfPresentation from UnitsOfPresentationVs