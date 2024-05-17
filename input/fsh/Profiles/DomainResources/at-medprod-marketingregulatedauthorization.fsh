Profile:  AT_MedicinalProduct_MarketingRegulatedAuthorization
Parent:   RegulatedAuthorization
Id:       at-medprod-marketingregulatedauthorization
Title:    "Marketing Regulated Authorization"
Description: "Contains the authorisation information of a medicinal product"

* id 1..1
* subject 1..1
* subject only Reference (AT_MedicinalProduct_MedicinalProductDefinition)

// Authorisation Number - Zulassungsnummer
* identifier 1..1
* identifier.system = $marketingAuthorizationNumberUrl
* identifier only AT_MedicinalProduct_Identifier

// Regulated authorisation of type Marketing Authorisation
* type 1..1
* type only AT_MedicinalProduct_CodeableConcept
* type = RegulatoryEntitlementTypeCs#220000000061 "Marketing Authorisation"

// Authorisation State - Zulassungsstatus
* status 1..1
* status only AT_MedicinalProduct_CodeableConcept
* status.coding from RegulatoryEntitlementStatusVs

// Validity - Gültigkeit des Zulassungsstatus //TODO Elga

// Authorisation Holder - Zulassungsinhaber
* holder.identifier 1..1

