Profile:  AT_MedicinalProduct_ManufacturedItemDefinition
Parent:   ManufacturedItemDefinition
Id:       at-medprod-manufacturedItemDefinition
Title:    "Manufactured item definition"
Description: "Manufactured Items are required to maintain the link between Ingredient and Packaged Medicinal Product"

// ID Fortlaufende Nr (PHAROS ADMPRO Ref Nr)

// Shortcut could be maintained
//* extension 1..1
//* extension only SubjectExtension

//* status 1..1 - Inherited Cardinality
* status = #"active"

//* manufacturedDoseForm 1..1 - Inherited Cardinality
* manufacturedDoseForm only AT_MedicinalProduct_CodeableConcept
* manufacturedDoseForm from PharmaceuticalDoseFormVs

//* unitOfPresentation 0..1 - Inherited Cardinality
* unitOfPresentation only AT_MedicinalProduct_CodeableConcept
* unitOfPresentation from UnitsOfPresentationVs