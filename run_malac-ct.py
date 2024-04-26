import os
import argparse
import subprocess
from pathlib import Path
from file_name_and_extension_extractor import *
from subprocess import Popen, PIPE, STDOUT
from datetime import datetime

parser = argparse.ArgumentParser(usage="%(prog)s [-i]")
parser.add_argument(
    "-i", "--input", help='file containing a list of paths of the resources to be converted by MaLaC-CT', required=True
)
args = parser.parse_args()

resource_file_path_list = []
with open(args.input, "r") as file:
    file_lines = file.read()
# read content of file only if it is not empty
if file_lines != "":
    resource_file_path_list = file_lines.split("\n")

# eliminate duplicate entries from git_log
resource_file_path_list = list(dict.fromkeys(resource_file_path_list))

print("---------------------------------------------------")
print("Determined resource file paths (duplicates eliminated):")
print("")
print(resource_file_path_list)
print("")
print("---------------------------------------------------")

# tuple specifying the order of file formats converted by malac-ct.
#  - I.e. if for resource "A" the file formats ".x" and ".y" have been changed, only ".y" will be passed on to
#    malac-ct if ".y" comes before ".x"
#  - file formats that do not exist in this tuple will not be passed on to malac-ct
# for MIGRATION phase
resource_type_file_format_priorities = {"CodeSystem":(".1.propcsv.xlsx", ".4.fhir.xml", ".4.fhir.json", ".1.spreadct.xlsx", ".2.claml.xml", ".1.svsextelga.xml", ".3.claml.xml", ".1.propcsv.csv", ".2.fsh", ".1.fsh"),
                                        "ValueSet":(".1.propcsv.xlsx", ".4.fhir.xml", ".4.fhir.json", ".1.spreadct.xlsx", ".1.svsextelga.xml", ".2.claml.xml", ".3.claml.xml", ".1.propcsv.csv", ".2.fsh", ".1.fsh")}
# for PRODUCTION phase
#file_format_priorities = (".1.propcsv.csv", ".2.fsh", ".1.fsh", ".3.claml.xml", ".2.claml.xml")

changed_resource_file_path_dict, changed_resource_name_set = retrieve_resource_file_path_and_name_set(resource_file_path_list, resource_type_file_format_priorities)

# list of parameters for malac-ct
parameter_list = ["python", "./malac-ct/malac_ct.py",
        "-langArg", "de-AT",
        "-convSrv", os.environ['convertFHIRServer'],
        "-url", os.environ['TERMGIT_CANONICAL'] + "/",
        "-appndProcTermTo", "./terminologies/terminologiesMetadata.csv",
        "-appndProcTermTo", "./processedTerminologies.csv",
        "-convTs", datetime.now().strftime("%Y-%m-%dT%X.0000Z"),
        "-ext", "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-ext-valueset-systemoid",
        "-ext", "http://hl7.org/fhir/StructureDefinition/codesystem-replacedby",
        "-ext", "http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder"]

if 'TURN_OFF_VERIFICATION_IN_REST_CALLS' in os.environ and os.environ['TURN_OFF_VERIFICATION_IN_REST_CALLS'] == 'true':
    parameter_list.append('-turnOffVerif')

# if environment variable is set accordingly, add the parameter to the parameter list
if 'convertFHIRServerUser' in os.environ and os.environ['convertFHIRServerUser']:
    parameter_list.append('-convSrvUser')
    parameter_list.append(os.environ['convertFHIRServerUser'])

# if environment variable is set accordingly, add the parameter to the parameter list
if 'convertFHIRServerUserPassword' in os.environ and os.environ['convertFHIRServerUserPassword']:
    parameter_list.append('-convSrvPw')
    parameter_list.append(os.environ['convertFHIRServerUserPassword'])


# if environment variable is set accordingly, add the parameter to the parameter list
# in order to use an additional request header for accessing tergi
if 'convertFHIRServerTergiTunnelToken' in os.environ and os.environ['convertFHIRServerTergiTunnelToken']:
    parameter_list.append('-convSrvTTT')
    parameter_list.append(os.environ['convertFHIRServerTergiTunnelToken'])

# if environment variable is set accordingly, add the parameter to the parameter list
# in order to have all artifacts uploaded to the FHIR server
if 'UPLOAD_ARTIFACTS' in os.environ and os.environ['UPLOAD_ARTIFACTS'] == 'true':
    # upload artifacts if pipeline is running on the default branch
    # OR
    # if UPLOAD_ARTIFACTS_ALL_BRANCHES is set to true, i.e. allows upload from all branches
    if os.environ['CI_COMMIT_BRANCH'] == os.environ['CI_DEFAULT_BRANCH'] or 'UPLOAD_ARTIFACTS_ALL_BRANCHES' in os.environ and os.environ['UPLOAD_ARTIFACTS_ALL_BRANCHES'] == 'true':
        parameter_list.append('-up2convSrv')

# make sure includes and redirects directories exists
Path('./secure_files_4_fhir_upload/').mkdir(parents=True, exist_ok=True)
# upload artifacts to additional FHIR servers if pipeline is running on the default branch
if os.environ['CI_COMMIT_BRANCH'] == os.environ['CI_DEFAULT_BRANCH']:
    for filename in os.listdir('./secure_files_4_fhir_upload/'):
        with open(os.path.join('./secure_files_4_fhir_upload/', filename), 'r') as file:
            parameter_list.append('-up2addlServer')
            parameter_list.append(file.read())

# append parameter for input file
parameter_list.append('-i')

for resource_type in changed_resource_file_path_dict.keys():
    print('malac-ct is now processing following resource type: ' + resource_type)
    for resource_file_path in changed_resource_file_path_dict[resource_type]:
        print('malac-ct subprocess for: ' + resource_file_path)
        # append path of resource file
        parameter_list.append("./" + resource_file_path)
        # execute MaLaC-CT; with check=True an exception will be raised in case of an error within the subprocess
        subprocess.run(parameter_list, check=True)
        # remove path of resource file
        parameter_list.pop()
