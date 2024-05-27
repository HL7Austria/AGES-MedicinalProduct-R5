Profile:  AT_MedicinalProduct_MarketingRegulatedAuthorization
Parent:   RegulatedAuthorization
Id:       at-medprod-marketingRegulatedAuthorization
Title:    "Marketing Regulated Authorization"
Description: "Contains the authorisation information of a medicinal product"

// id = Zulassungsnummer
* subject 1..1
* subject only Reference (AT_MedicinalProduct_MedicinalProductDefinition)

// Authorisation Number - Zulassungsnummer
* identifier ^short = "Business identifier for the authorization, typically assigned by the authorizing body (authorization number)"
* identifier 1..1
* identifier.system = $marketingAuthorizationNumberUrl
* identifier only AT_MedicinalProduct_Identifier

// Regulated authorisation of type Marketing Authorisation
* type 1..1
* type only AT_MedicinalProduct_CodeableConcept
* type = RegulatoryEntitlementTypeCs#220000000061

// Authorisation State - Zulassungsstatus
* status ^short = "The status that is authorised e.g. approved. Intermediate states can be tracked with cases and applications (authorization status)"
* status 1..1
* status only AT_MedicinalProduct_CodeableConcept
* status.coding from RegulatoryEntitlementStatusVs

// Validity - Gültigkeit des Zulassungsstatus //TODO Elga

// Authorisation  - Zulassungsinhaber
* holder ^short = "The organization that has been granted this authorization, by the regulator (authorization holder)"
* holder.identifier 1..1
* holder.identifier.system 1..1
* holder.identifier.system = "https://spor.ema.europa.eu/omswi"
* holder.identifier.value ^short = "This value contains the Location ID from the EMA SPOR OMS System"
* holder.identifier.value 1..1
* holder.display 1..1
* holder.display ^short = "The name of the marketing authorisation holder"
