Profile:  AT_MedicinalProduct_AdministrableProductDefinition
Parent:   AdministrableProductDefinition
Id:       at-medprod-administrableProductDefinition
Title:    "Administrable product definition"
Description: "Required for the attribute Route of Administration"

// ID PHP Grz

* identifier 1..1
* identifier only AT_MedicinalProduct_Identifier
* identifier.system = $GRZ

//* status 1..1 - Inherited Cardinality
* status = #"active"

* formOf 1..1
* formOf only Reference(AT_MedicinalProduct_MedicinalProductDefinition)

// Doseform after constituation (new)
* administrableDoseForm only AT_MedicinalProduct_CodeableConcept
* administrableDoseForm from PharmaceuticalDoseFormVs

* unitOfPresentation only AT_MedicinalProduct_CodeableConcept
* unitOfPresentation from UnitsOfPresentationVs

// Link between Manufactured item and Pharmaceutical Product
* producedFrom 0..1
* producedFrom only Reference(AT_MedicinalProduct_ManufacturedItemDefinition)

//* routeOfAdministration 1..* - Inherited Cardinality
* routeOfAdministration ^short = "Route of administration"
* routeOfAdministration.code only AT_MedicinalProduct_CodeableConcept
* routeOfAdministration.code from RoutesAndMethodsOfAdministrationVs
