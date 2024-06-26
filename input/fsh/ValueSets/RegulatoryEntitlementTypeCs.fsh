CodeSystem: RegulatoryEntitlementTypeCs
Id: 220000000060
Title: "Regulatory Entitlement"
Description:  "Regulatory Entitlement"
// The line below overrides the canonical URL (which is the default).
* ^url = "https://spor.ema.europa.eu/v1/lists/220000000060"
* ^status = #active
* ^version = "5.0.0" // should represent the version of the code system not the FHIR version
* ^experimental = false
* ^publisher = "European Medicines Agency"
//* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America" //TODO - get this code
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
* #220000000061 "Marketing Authorisation"
* #220000000062 "Orphan Designation"
* #220000000063 "Parallel Trade Authorisation"
* #220000000065 "Paediatric Use"
* #220000000077 "Market Protection"
* #220000000096 "GMP Inside EEA"
* #220000000097 "GMP Outside EEA"
* #220000000098 "SME"
* #220000000099 "Manufacturing Authorisation"