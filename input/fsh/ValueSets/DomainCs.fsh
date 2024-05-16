//Used for Code System update test.
CodeSystem: DomainCs
Id: 100000000004
Title: "Domain"
Description:  "Domain"
* ^meta.versionId = "5.0.0" // TODO: ??
* ^meta.lastUpdated = "2023-08-03T11:35:00.198Z"
// The line below overrides the canonical URL (which is the default). 
* ^url = $domainUrl
* ^status = #active
* ^version = "5.0.0"
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