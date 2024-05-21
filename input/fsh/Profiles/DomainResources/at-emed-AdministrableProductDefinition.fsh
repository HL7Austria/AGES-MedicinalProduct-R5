Profile:  at-emed-AdministrableProductDefinition
Parent:   AdministrableProductDefinition
Id:       at-emed-AdministrableProductDefinition
Title:    "Administrable product definition"
Description: "Required for the attribute Route of Administration"

* id 1..1

* identifier 1..1
* identifier only EmaMpIdentifier

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
* producedFrom only Reference(EmaManufacturedItemDefinition)

//* routeOfAdministration 1..* - Inherited Cardinality
* routeOfAdministration.code only RefTermCodeableConcept
* routeOfAdministration.code from RoutesAndMethodsOfAdministrationVs
* routeOfAdministration.targetSpecies 0..1
* routeOfAdministration.targetSpecies.code only EmaRefTermCodeableConcept
* routeOfAdministration.targetSpecies.code from TargetSpeciesVs

//* device 0..* - Inherited Cardinality
* device only Reference(EmaDeviceDefinition)
