Profile:  MarketingRegulatedAuthorization
Parent:   CommonRegulatedAuthorization
Id:       MarketingRegulatedAuthorization
Title:    "Marketing Regulated Authorization"
Description: "Contains the Authorisation information of a Medicinal Product"

* id 1..1

// Authorisation Number - Zulassungsnummer
* identifier 1..1
* identifier.system = "$marketingAuthorizationNumberUrl"
* identifier only Identifier-eMed

* type 1..1
* type only EmaRefTermCodeableConcept
* type = RegulatoryEntitlementTypeCs#220000000061

// Authorisation State - Zulassungsstatus
// Validity - Gültigkeit des Zulassungsstatus //TODO Elga

// Authorisation Holder - Zulassungsinhaber


