CodeSystem: UnitsOfMeasurementCs
Id: 100000110633
Title: "Units Of Measurement"
Description:  "Units Of Measurement"
// The line below overrides the canonical URL (which is the default).
* ^url = $unitsOfMeasurement
* ^status = #active
* ^version = "5.0.0" // should represent the version of the code system not the FHIR version
* ^experimental = false
* ^publisher = "European Medicines Agency"
//* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America" //TODO - get this code
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
// Todo: Copy the list of UnitsOfMeasurement in here