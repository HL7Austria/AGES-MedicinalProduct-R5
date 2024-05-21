Profile:  at-emed-AdministrableProductDefinition
Parent:   AdministrableProductDefinition
Id:       at-emed-AdministrableProductDefinition
Title:    "Administrable product definition"
Description: "Required for the attribute Route of Administration"

* id 1..1

* identifier 1..1
* identifier only AT_MedicinalProduct_Identifier
* identifier.system = $GRZ

//* status 1..1 - Inherited Cardinality
* status = #"active"

* formOf 1..1
* formOf only Reference(http://hl7.org/fhir/StructureDefinition/MedicinalProductDefinition)

//* administrableDoseForm 0..1 - Inherited Cardinality
//* administrableDoseForm only EmaRefTermCodeableConcept
//* administrableDoseForm from PharmaceuticalDoseFormVs

//* unitOfPresentation 0..1 - Inherited Cardinality
//* unitOfPresentation only EmaRefTermCodeableConcept
//* unitOfPresentation from UnitsOfPresentationVs

* producedFrom 0..1
* producedFrom only Reference(http://hl7.org/fhir/StructureDefinition/ManufacturedItemDefinition)

//* routeOfAdministration 1..* - Inherited Cardinality
* routeOfAdministration.code only AT_MedicinalProduct_CodeableConcept
* routeOfAdministration.code from RoutesAndMethodsOfAdministrationVs
