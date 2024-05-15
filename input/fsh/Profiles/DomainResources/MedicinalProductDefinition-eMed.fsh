Profile:  MedicinalProductDefinition-eMed
Parent:   MedicinalProductDefinition
Id:       MedicinalProductDefinition-eMed
Title:    "MedicinalProductDefinition-Med"
Description: "Medicinal Product Definition Profiled resource containing a subset of attributes needed for the Austrian eHealth Community"
* ^status = #draft

// Identifiers
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.description = "Slice defining two different types of identifiers"
* identifier ^slicing.ordered = false
* identifier ^slicing.rules = #closed

* identifier contains
    pmsId 0..1 and
    GRZ 1..1

* identifier[pmsId].system = $grz
* identifier[pmsId] only Identifier-eMed

* identifier[pmsId].system = $pmsIdUrl
* identifier[pmsId] only Identifier-eMed

// Domain - Domäne (Nur Human)
* domain only EmaRefTermCodeableConcept
* domain.coding from DomainVs (required)


// Authorisation Name (Full Name) - Name der Arzneispezialität
* name.type only EmaRefTermCodeableConcept

// Name parts (slices):
* name.part ^slicing.discriminator.type = #value
* name.part ^slicing.discriminator.path = "type"
* name.part ^slicing.rules = #open
* name.part ^slicing.description = "Slice based on the part.type.coding.code"
* name.part.part 1..1
* name.part.type.coding from MedicinalProductNamePartTypeVs (required)
* name.part.type.coding only EmaNamePartTypeCoding
* name.part contains 
inventedName 1..1 and // Invented Name - Zulassungsname
// Todo: Trade Name - Handelsname

* name.part[inventedName].type = MedicinalProductNamePartTypeCs#220000000002
//* name.part[pharmaceuticalDoseForm].type = MedicinalProductNamePartTypeCs#220000000005

// Pharmaceutical Dose Form - Darreichungsform (ELGA_MedikationDarreichungsform)
* combinedPharmaceuticalDoseForm 1..1
* combinedPharmaceuticalDoseForm only EmaRefTermCodeableConcept


// Prescription requirements - Rezeptpflichtstatus

// Immunisation target combination - Kombinationsimpfung

// Drug Interaction - Wechselwirkung (ELGA_MedikationWechselwirkungsRelevant)

// TODO Lebendimpfstoff

// ATC Code

// Route of administration

