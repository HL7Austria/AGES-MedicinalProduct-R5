import os

# map containing currently implemented file formats and their format title
implemented_file_formats = {".4.fhir.xml" : ["FHIR® R4 xml", ""],
                            ".4.fhir.json" : ["FHIR® R4 json", ""],
                            ".1.fsh" : ["fsh v1", ""],
                            ".2.fsh" : ["fsh v2", ""],
                            ".2.claml.xml" : ["ClaML v2", ""],
                            ".3.claml.xml" : ["ClaML v3", ""],
                            ".1.propcsv.csv" : ["propCSV v1", ""],
                            ".1.propcsv.xlsx" : ["propXLSX v1", ""],
                            ".1.spreadct.xlsx" : ["spreadCT v1", ""],
                            ".1.svsextelga.xml" : ["SVSextELGA v1", "<b>Warning! DEPRECATED!</b><br/>This format can technically not contain all the information that is available in the other formats.<br/>This format is only available for legacy purposes."],
                            ".2.svsextelga.xml" : ["SVSextELGA v2", "<b>Warning! DEPRECATED!</b><br/>This format can technically not contain all the information that is available in the other formats.<br/>This format is only available for legacy purposes. <b>However, all concept properties are available.</b>"],
                            ".1.outdatedcsv.csv" : ["outdatedCSV v1", "<b>Warning! DEPRECATED!</b><br/>This format can technically not contain all the information that is available in the other formats.<br/>This format is only available for legacy purposes."],
                            ".2.outdatedcsv.csv" : ["outdatedCSV v2", "<b>Warning! DEPRECATED!</b><br/>This format can technically not contain all the information that is available in the other formats.<br/>This format is only available for legacy purposes. <b>However, all concept properties are available.</b>"]} # TODO 1.decor.xml

# retrieve the resource's file name and its file format
def file_name_and_extension_extractor(resource_file_name):
  for file_format in implemented_file_formats.keys():
    if resource_file_name.endswith(file_format):
      return resource_file_name.replace(file_format, ""), file_format

def file_path_file_name_and_extension_extractor(resource_file_path):
  return file_name_and_extension_extractor(os.path.basename(resource_file_path))

def file_path_type_file_name_and_extension_extractor(resource_file_path):
  file_name, file_extension = file_path_file_name_and_extension_extractor(resource_file_path)
  if file_name.find('-') != -1:
    type = file_name[:file_name.find('-')]
  else:
    type = "NO_TYPE_FOUND"
  return type, file_name, file_extension

def retrieve_resource_file_path_and_name_set(resource_file_path_list, resource_type_file_format_priorities, existing_files_only=True):
  # dictionary storing the file paths and resource names resources according to their file format
  resources_dictionary = {}

  # sort each resource_file_path into the dictionary according to its file format
  for resource_file_path in resource_file_path_list:
    # consider only those files that still exist, thus automatically ignoring files that do not exist
    # OR consider all files, if existing_files_only is set to false
    if os.path.exists(resource_file_path) or not existing_files_only:
      # determine resource type, name and its file format
      type, resource_name, file_format = file_path_type_file_name_and_extension_extractor(resource_file_path)

      if type not in resources_dictionary.keys():
        resources_dictionary[type] = dict.fromkeys(implemented_file_formats.keys())

      # if no dictionary entry for the file format exists it will be created containing the
      # current resource's file path and resource name
      if resources_dictionary[type][file_format] is None:
        resources_dictionary[type][file_format] = [(resource_file_path, resource_name)]
      # if there exists a dictionary entry for the file format simply add an entry with the
      # current resource's file path and resource name
      else:
        resources_dictionary[type][file_format].append((resource_file_path, resource_name))

  print("-------- resources_dictionary --------")
  print(resources_dictionary)

  # for each resource type a set with the file paths of the resources (including file type) will be created
  resource_file_path_dict = dict.fromkeys(resource_type_file_format_priorities.keys())
  for resource_type in resource_file_path_dict.keys():
    resource_file_path_dict[resource_type] = set()
  # set with the names of all resources (without file type)
  resource_name_set = set()

  # according to the file format priorities scan the dictionary of resources for
  # files that may be passed on to malac-ct
  for resource_type in resource_type_file_format_priorities:
    for file_format in resource_type_file_format_priorities[resource_type]:
      # proceed only if there exists a dictionary entry for the current file format
      if resource_type in resources_dictionary.keys() and resources_dictionary[resource_type][file_format] is not None:
        # retrieve the list of resource files having the current file format
        resource_list = resources_dictionary[resource_type][file_format]
        # loop each list entry (tuple of resource file path and resource name)
        for resource_tuple in resource_list:
          # retrieval of file path and name of the resource
          resource_file_path, resource_name = resource_tuple[0], resource_tuple[1]

          # proceed only if the given resource has not yet been added to resource_name_set

          # this is the centerpiece of guaranteeing that file formats with higher priority will be passed on to
          # malac-ct instead of file formats with lower priority.
          if resource_name not in resource_name_set:
            # store the resource name in the set of resources
            resource_name_set.add(resource_name)
            # store the resource file path in the set of resource's file paths
            resource_file_path_dict[resource_type].add(resource_file_path)

  print("-------- resource_name_set --------")
  print(resource_name_set)
  print("-------- resource_file_path_dict --------")
  print(resource_file_path_dict)

  return resource_file_path_dict, resource_name_set

if __name__ == "__main__":
  print(file_path_type_file_name_and_extension_extractor("test/CodeSystem-test.4.fhir.xml")) # CodeSystem | CodeSystem-test | .4.fhir.xml
  print(file_path_type_file_name_and_extension_extractor("test/ValueSet-vs.4.fhir.xml")) # ValueSet | ValueSet-vs | .4.fhir.xml
  print(file_path_type_file_name_and_extension_extractor("test/ValueSetvs.4.fhir.xml")) # NO_TYPE_FOUND | ValueSetvs | .4.fhir.xml

  # tuple specifying the order of file formats converted by malac-ct.
  #  - I.e. if for resource "A" the file formats ".x" and ".y" have been changed, only ".y" will be passed on to
  #    malac-ct if ".y" comes before ".x"
  #  - file formats that do not exist in this tuple will not be passed on to malac-ct
  resource_type_file_format_priorities = {"CodeSystem":(".1.propcsv.xlsx", ".4.fhir.xml", ".4.fhir.json", ".1.spreadct.xlsx", ".2.claml.xml", ".1.svsextelga.xml", ".3.claml.xml", ".1.propcsv.csv", ".2.fsh", ".1.fsh"),
                                        "ValueSet":(".1.propcsv.xlsx", ".4.fhir.xml", ".4.fhir.json", ".1.spreadct.xlsx", ".1.svsextelga.xml", ".2.claml.xml", ".3.claml.xml", ".1.propcsv.csv", ".2.fsh", ".1.fsh")}
  codesystem = "test/CodeSystem-testcs"
  valueset = "test/ValueSet-testvs"

  resource_file_path_list = []
  for file_format in implemented_file_formats.keys():
    resource_file_path_list.append(codesystem + file_format)
    resource_file_path_list.append(valueset + file_format)

  file_path_dict, name_set = retrieve_resource_file_path_and_name_set(resource_file_path_list, resource_type_file_format_priorities, False)
  print(file_path_dict) # {'CodeSystem': {'test/CodeSystem-testcs.2.claml.xml'}, 'ValueSet': {'test/ValueSet-testvs.1.svsextelga.xml'}} # note, that order within a resource type may be different
  print(name_set) # {'ValueSet-testvs', 'CodeSystem-testcs'} # note, that order may be different

