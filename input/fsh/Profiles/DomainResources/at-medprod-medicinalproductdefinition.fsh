Profile:  AT_MedicinalProduct_MedicinalProductDefinition
Parent:   MedicinalProductDefinition
Id:       at-medprod-medicinalproductdefinition
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
* domain ^short = "If this medicine applies to human or veterinary uses (domain)"
* domain only AT_MedicinalProduct_CodeableConcept
* domain.coding from DomainVs (required)

// Authorisation Name (Full Name) - Name der Arzneispezialität
* name.productName ^short = "The full product name (authorization name)"

// Name parts (slices):
* name.part ^slicing.discriminator.type = #value
* name.part ^slicing.discriminator.path = "type"
* name.part ^slicing.description = "Slice based on the part.type.coding.code"
* name.part ^slicing.ordered = false
* name.part ^slicing.rules = #open
* name.part.type.coding from MedicinalProductNamePartTypeVs (required)
* name.part contains
inventedName 1..1 and // Invented Name - Part name
tradeName 1..1 // Trade Name - Handelsname

* name.part[inventedName].type ^short = "Part name"
* name.part[inventedName].type only AT_MedicinalProduct_CodeableConcept
* name.part[inventedName].type = MedicinalProductNamePartTypeCs#220000000002
* name.part[tradeName].type ^short = "Trade name"
* name.part[tradeName].type only AT_MedicinalProduct_CodeableConcept
* name.part[tradeName].type = AdditionalMedicinalProductNamePartTypeCs#tradeName

//* name.part[pharmaceuticalDoseForm].type = MedicinalProductNamePartTypeCs#220000000005

// Pharmaceutical Dose Form - Darreichungsform (ELGA_MedikationDarreichungsform)
* combinedPharmaceuticalDoseForm ^short = "The dose form for a single part product, or combined form of a multiple part product (pharmaceutical dose form)"
* combinedPharmaceuticalDoseForm 1..1
* combinedPharmaceuticalDoseForm only AT_MedicinalProduct_CodeableConcept

// Prescription requirements - Rezeptpflichtstatus
* legalStatusOfSupply ^short = "The legal status of supply of the medicinal product as classified by the regulator (prescription requirement state)"
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
    ATCCodePharos 1..* and
    ATCCodeWHO 0..*

* classification.coding[interactionRelevance].system ^short = "Drug intercation"
* classification.coding[interactionRelevance].system = $interactionRelevance // Drug Interaction - Wechselwirkung (ELGA_MedikationWechselwirkungsRelevant)
* classification.coding[elgaImpfziel].system ^short = "Immunization target"
* classification.coding[elgaImpfziel].system = $elgaImpfziel // Immunisation target combination - Kombinationsimpfung
* classification.coding[ATCCodePharos].system = $ATCCodePharos // ATC Code
* classification.coding[ATCCodePharos].system ^short = "ATC Codes from RMS merged with local Austrian codes"
* classification.coding[ATCCodeWHO].system ^short = "WHO ATC"
* classification.coding[ATCCodeWHO].system = $ATCCodeWHO // ATC Code

// TODO Lebendimpfstoff




