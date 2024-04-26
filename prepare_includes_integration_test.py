import os
import re
from subprocess import Popen, PIPE, STDOUT
from pathlib import Path
from sys import float_repr_style
from shutil import copyfile
from file_name_and_extension_extractor import *

with open("run_malac-ct_job_url.txt", "r") as file:
  run_malac_ct_job_url = file.read()

resource_file_path_list=[]
# get names of the changed resourcs
with open("resource_file_path_list.txt", "r") as file:
  file_lines = file.read()
  # read content of file only if it is not empty
  if file_lines != "":
    resource_file_path_list = file_lines.split("\n")

# tuple specifying the order of file formats converted by malac-ct.
#  - I.e. if for resource "A" the file formats ".x" and ".y" have been changed, only ".y" will be passed on to
#    malac-ct if ".y" comes before ".x"
#  - file formats that do not exist in this tuple will not be passed on to malac-ct
resource_type_file_format_priorities = {"CodeSystem":(".1.propcsv.xlsx", ".4.fhir.xml", ".4.fhir.json", ".1.spreadct.xlsx", ".2.claml.xml", ".1.svsextelga.xml", ".3.claml.xml", ".1.propcsv.csv", ".2.fsh", ".1.fsh"),
                                        "ValueSet":(".1.propcsv.xlsx", ".4.fhir.xml", ".4.fhir.json", ".1.spreadct.xlsx", ".1.svsextelga.xml", ".2.claml.xml", ".3.claml.xml", ".1.propcsv.csv", ".2.fsh", ".1.fsh")}

resource_file_path_dict, resource_name_set = retrieve_resource_file_path_and_name_set(resource_file_path_list, resource_type_file_format_priorities)

# make sure includes directory exists
Path("./input/includes/").mkdir(parents=True, exist_ok=True)

# for every changed resource
for resourceName in resource_name_set:
  print('next resource is: ' + resourceName)
  # create dummy of previous versions
  with open("./input/includes/"+resourceName+"-previous-versions.xhtml", 'w', encoding='utf-8') as file:
    file.write('<div role="alert" class="alert alert-danger">\r\n<p>This is the result of an integration test. No previous versions have been created. No previous versions are available in this build.</p>\r\n</div>')
  # create dummy of download pages
  with open('./input/includes/'+resourceName+'-download.xhtml', 'w', encoding='utf-8') as file:
    file.write('<div role="alert" class="alert alert-danger">\r\n<p>This is the result of an integration test. Please inspect the artifacts of job <code>run_malac-ct_integration_test</code> under <a href="'+run_malac_ct_job_url+'">'+run_malac_ct_job_url+'</a></p>\r\n</div>')