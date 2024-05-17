//Used for Code System update test.
CodeSystem: DomainCs
Id: 100000000004
Title: "Domain"
Description:  "Domain"
// The line below overrides the canonical URL (which is the default).
* ^url = https://spor.ema.europa.eu/v1/lists/100000000004
* ^status = #active
* ^version = "5.0.0" // should represent the version of the code system not the FHIR version
* ^experimental = false
* ^publisher = "European Medicines Agency"
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
//* ^property[0].code = "status" // TODO: Get this working.
//* ^property[=].type = "code" // TODO: Get this working.
* #100000000012 "Human use"
* #100000000013 "Veterinary use"
//* #100000000013 ^property[0].valueCode = #retired // TODO: Re-test this.
* #100000000014 "Human and Veterinary use"
//* #100000000014 ^property[0].valueCode = #valid // TODO: Re-test this.