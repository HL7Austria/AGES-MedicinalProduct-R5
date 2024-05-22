Profile:  AT_MedicinalProduct_MedicinalProductDefinition
Parent:   MedicinalProductDefinition
Id:       at-medprod-medicinalproductdefinition
Title:    "Medicinal Product Definition"
Description: "Medicinal Product Definition profiled resource containing a subset of attributes needed for the Austrian eHealth Community"

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

* combinedPharmaceuticalDoseForm.coding ^slicing.discriminator.type = #pattern
* combinedPharmaceuticalDoseForm.coding ^slicing.discriminator.path = "system"
* combinedPharmaceuticalDoseForm.coding ^slicing.rules = #closed
* combinedPharmaceuticalDoseForm.coding ^slicing.description = "One of 4 Lists can be a dose form"
* combinedPharmaceuticalDoseForm.coding ^slicing.ordered = false

*combinedPharmaceuticalDoseForm.coding[doseform1].system = $doseform1 (exactly)

// Prescription requirements - Rezeptpflichtstatus

// Immunisation target combination - Kombinationsimpfung

// Drug Interaction - Wechselwirkung (ELGA_MedikationWechselwirkungsRelevant)

// TODO Lebendimpfstoff

// ATC Code


