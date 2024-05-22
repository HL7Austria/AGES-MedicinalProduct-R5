Profile:  AT_MedicinalProduct_MedicinalProductDefinition
Parent:   MedicinalProductDefinition
Id:       at-medprod-medicinalProductDefinition
Title:    "Medicinal Product Definition"
Description: "Medicinal Product Definition profiled resource containing a subset of attributes needed for the Austrian eHealth Community"

// Id = Grundzahl

// Identifiers
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.description = "Slice defining two different types of identifiers"
* identifier ^slicing.ordered = false
* identifier ^slicing.rules = #closed

* identifier contains
    pmsId 0..1 and
    GRZ 1..1

* identifier[pmsId].system = $GRZ
* identifier[pmsId] only AT_MedicinalProduct_Identifier

* identifier[GRZ].system = $pmsIdUrl
* identifier[GRZ] only AT_MedicinalProduct_Identifier

// Domain - Domäne (Nur Human)
* domain only AT_MedicinalProduct_CodeableConcept
* domain.coding from DomainVs (required)


// Authorisation Name (Full Name) - Name der Arzneispezialität
* name.type only AT_MedicinalProduct_CodeableConcept

// Name parts (slices):
* name.part ^slicing.discriminator.type = #value
* name.part ^slicing.discriminator.path = "type"
* name.part ^slicing.description = "Slice based on the part.type.coding.code"
* name.part ^slicing.ordered = false
* name.part ^slicing.rules = #open
* name.part.type.coding from MedicinalProductNamePartTypeVs (required)
* name.part.type.coding only AT_MedicinalProduct_Coding
* name.part contains
inventedName 1..1 // Invented Name - Zulassungsname
// Todo: Trade Name - Handelsname

* name.part[inventedName].type = MedicinalProductNamePartTypeCs#220000000002
//* name.part[pharmaceuticalDoseForm].type = MedicinalProductNamePartTypeCs#220000000005

// Pharmaceutical Dose Form - Darreichungsform (ELGA_MedikationDarreichungsform)
* combinedPharmaceuticalDoseForm 1..1
* combinedPharmaceuticalDoseForm only AT_MedicinalProduct_CodeableConcept

// Prescription requirements - Rezeptpflichtstatus
* legalStatusOfSupply 1..1
* legalStatusOfSupply only AT_MedicinalProduct_CodeableConcept
* legalStatusOfSupply from legalStatusForTheSupplyVs

// Classifications for the rest
* classification only AT_MedicinalProduct_CodeableConcept
* classification.coding ^slicing.discriminator.type = #pattern
* classification.coding ^slicing.discriminator.path = "system"
* classification.coding ^slicing.rules = #open
* classification.coding ^slicing.description = "Classification contains ATC Code WHO, ATC Code RMS, Immunisation Target, Lebendimpfstoff, Wechselwirkung"
* classification.coding ^slicing.ordered = false
* classification.coding contains 
    interactionRelevance 0..1 and
    elgaImpfziel 0..1 and
    ATCCodeRMS 0..1 and
    ATCCodeWHO 0..1

* classification.coding[interactionRelevance].system = $interactionRelevance // Drug Interaction - Wechselwirkung (ELGA_MedikationWechselwirkungsRelevant)
* classification.coding[elgaImpfziel].system = $elgaImpfziel // Immunisation target combination - Kombinationsimpfung
* classification.coding[ATCCodeRMS].system = $ATCCodeRMS // ATC Code
* classification.coding[ATCCodeWHO].system = $ATCCodeWHO // ATC Code
// TODO Lebendimpfstoff




