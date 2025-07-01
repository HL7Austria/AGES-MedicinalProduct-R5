Extension: CodeSystemName
Id: codeSystemName
Description: "Name of the coding system the 'coding' element belongs to as the number is not very explicative"
* ^url = $codeSystemNameExtensionUrl
* ^context.type = #element
* ^context.expression = "Coding"
* url = $codeSystemNameExtensionUrl (exactly)
* value[x] only string
* valueString ^short = "Code System Name"
* valueString ^definition = "The name of the List used"
