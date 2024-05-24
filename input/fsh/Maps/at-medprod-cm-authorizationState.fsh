Instance: at-medprod-cm-authorizationState
InstanceOf: ConceptMap
Usage: #definition
* url = "https://www.ages.at/fhir/ConceptMap/at-medprod-cm-authorizationState"
* version = "0.1.0"
* name = "AT_MedicinalProduct_CM_AuthorizationState"
* title = "Authorization State Mapping"
* status = #active
* experimental = false
* publisher = "AGES - PHAROS"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.ages.at"
* description = "A mapping between the authorization state used in the \"ASP-Liste\" and the status used in the RegulatedAuthorization"
* jurisdiction = urn:iso:std:iso:3166#AT
* sourceScopeUri = "https://www.ages.at/fhir/ValueSet/asp-liste-authorizationState"
* targetScopeUri = "https://ema.europa.eu/fhir/vs/regulatoryEntitlementStatus"
* group.source = "https://www.ages.at/fhir/CodeSystem/asp-liste-authorizationState"
* group.target = "https://spor.ema.europa.eu/v1/lists/100000072049"
* group.element[0].code = #zugelassen
* group.element[=].target.code = #100000072099
* group.element[=].target.relationship = #source-is-narrower-than-target
* group.element[+].code = #registriert
* group.element[=].target.code = #100000072099
* group.element[=].target.relationship = #source-is-narrower-than-target
* group.element[+].code = #parallelimport
* group.element[=].target.code = #100000072099
* group.element[=].target.relationship = #source-is-narrower-than-target
* group.element[+].code = #abgelehnt
* group.element[=].target.code = #220000000067
* group.element[=].target.relationship = #equivalent
* group.element[+].code = #ruhend
* group.element[=].target.code = #100000072122
* group.element[=].target.relationship = #equivalent
* group.element[+].code = #aufgehoben
* group.element[=].target.code = #200000010409
* group.element[=].target.relationship = #equivalent