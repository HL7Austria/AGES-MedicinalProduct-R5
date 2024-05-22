CodeSystem: QuantityOperatorCs
Id: 100000000008
Title: "Quantity Operator"
Description:  "Quantity Operator"
// The line below overrides the canonical URL (which is the default).
* ^url = "https://spor.ema.europa.eu/v1/lists/100000000008"
* ^status = #active
* ^version = "5.0.0" // should represent the version of the code system not the FHIR version
* ^experimental = false
* ^publisher = "European Medicines Agency"
//* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America" //TODO - get this code
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
* #100000000049 "equal to"
* #100000000050 "less than"
* #100000000051 "more than"
* #100000000052 "less than or equal to"
* #100000000053 "more than or equal to"
* #100000000054 "equivalent to"
* #100000000055 "approximately equal to"
* #100000000056 "range"
* #200000024024 "average"
