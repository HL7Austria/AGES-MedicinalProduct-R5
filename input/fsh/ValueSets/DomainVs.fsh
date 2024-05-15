ValueSet: DomainVs
Id: domainVs
Title: "The Domain Value Set"
* ^url = "https://ema.europa.eu/fhir/vs/domain"
* insert SporVersion
* insert Publisher
* ^status = #active
* include codes from system DomainCs // TODO: where concept.property[0].valueCode is-a "valid"
