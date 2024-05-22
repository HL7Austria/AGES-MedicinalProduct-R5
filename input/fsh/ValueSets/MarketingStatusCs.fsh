//TODO add national values
CodeSystem: MarketingStatusCs
Id: 100000072052
Title: "Marketing Status"
Description:  "Marketing Status"
// The line below overrides the canonical URL (which is the default).
* ^url = "https://spor.ema.europa.eu/v1/lists/100000072052"
* ^status = #active
* ^version = "5.0.0" // should represent the version of the code system not the FHIR version
* ^experimental = false
* ^publisher = "European Medicines Agency"
//* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America" //TODO - get this code
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
* #100000072076 "Medicinal product not subject to medical prescription"
* #100000072074	"Not marketed"
* #100000072075	"No data provided"
* #100000072083	"Marketed"
* #200000026055	"Never marketed"
* #230000000000	"Temporarily unavailable"