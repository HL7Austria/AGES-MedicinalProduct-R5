CodeSystem: RegulatoryEntitlementStatusCs
Id: regulatoryEntitlementStatusCs
Title: "Regulatory Entitlement Status"
Description:  "Regulatory Entitlement Status"
* ^meta.versionId = "5.0.0" // TODO: ??
* ^meta.lastUpdated = "2023-08-03T11:35:00.198Z"
// The line below overrides the canonical URL (which is the default). 
* ^url = $regulatoryEntitlementStatusUrl
* ^status = #active
* ^version = "5.0.0"
* ^experimental = false
* ^publisher = "European Medicines Agency"
//* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America" //TODO - get this code
* ^jurisdiction.text = "European Union"
* ^caseSensitive = true
* ^content = #complete
* #100000072099 "Valid"
* #100000072100 "Expired"
* #100000072112 "Not renewed"
* #100000072113 "Withdrawn"
* #100000072114 "Withdrawn, unspecified"
* #100000072121 "Revoked"
* #100000072122 "Suspended"
* #100000072123 "Expired due to Sunset Clause"
* #200000010409 "Surrendered"
* #200000017707 "Valid - Transferred marketing authorisation"
* #200000017708 "Valid - Renewed/Varied"
* #200000026056 "Presubmission"
* #220000000066 "Pending"
* #220000000067 "Rejected"
