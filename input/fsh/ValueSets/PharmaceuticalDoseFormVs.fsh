ValueSet: PharmaceuticalDoseFormVs
Id: pharmaceuticalDoseFormVs
Title: "The Pharmaceutical Dose Form Value Set"
* ^url = "https://ema.europa.eu/fhir/vs/pharmaceuticalDoseForm"
* insert PublisherEMA
* ^status = #active
//* include codes from system CombinedPharmaceuticalDoseFormCs and PharmaceuticalDoseFormCs // TODO: This AND doesn't work.
* include codes from system PharmaceuticalDoseFormCs