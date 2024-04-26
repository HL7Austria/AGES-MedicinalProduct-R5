import sys
import requests
import os
from pathlib import Path

# this following function is nearly a 1:1 copy from malac-ct
def upload_to_fhir_server(input, FHIRServer, FHIRServerUser, FHIRServerUserPassword, FHIRServerTergiTunnelToken, verification, failIfUploadGoesWrong=False):

    input_file_ending = os.path.splitext(input)[1][1:]

    headers={ 'Content-Type' : 'application/fhir+'+input_file_ending+'; charset=utf-8' }
    if (FHIRServerTergiTunnelToken):
        headers['tergi-tunnel-token'] = FHIRServerTergiTunnelToken

    auth = None
    if (FHIRServerUser and FHIRServerUserPassword):
        auth = (FHIRServerUser, FHIRServerUserPassword)

    # convert the terminologit naming convention to the fhir naming convention 
    splittedBaseName = os.path.basename(input).split("-",1)
    resType = splittedBaseName[0]
    resName = splittedBaseName[1].replace("."+input_file_ending,"")
    FHIRServer += resType+"/"+resName

    with open(input, 'rb') as fhir_resource_file:
        if auth is None:
            res = requests.put(FHIRServer, headers=headers, data=fhir_resource_file, verify=verification)
        else:
            res = requests.put(FHIRServer, headers=headers, auth=auth, data=fhir_resource_file, verify=verification)

    print(res.text)
    if failIfUploadGoesWrong: res.raise_for_status()

# walk through all resoure files
for input in os.listdir('./input/resources'):
    input = './input/resources/' + input
    # upload it once to the given tergi
    # do env var checking like in https://stackoverflow.com/questions/40697845/what-is-a-good-practice-to-check-if-an-environmental-variable-exists-or-not
    upload_to_fhir_server(input, os.environ['convertFHIRServer'], os.getenv('convertFHIRServerUser'), 
            os.getenv('convertFHIRServerUserPassword'), os.getenv('convertFHIRServerTergiTunnelToken'), 
            os.getenv('TURN_OFF_VERIFICATION_IN_REST_CALLS'), failIfUploadGoesWrong=True)

    # further upload to all given fire server
    # make sure the secure files directories exists
    Path('./secure_files_4_fhir_upload/').mkdir(parents=True, exist_ok=True)
    # upload artifacts to additional FHIR servers if pipeline is running on the default branch
    for filename in os.listdir('./secure_files_4_fhir_upload/'):
        with open(os.path.join('./secure_files_4_fhir_upload/', filename), 'r') as file:
            import json
            addlServerDict = json.loads(file.read())
            upload_to_fhir_server(input, addlServerDict["FHIRServer"], addlServerDict["FHIRServerUser"], addlServerDict["FHIRServerUserPassword"], addlServerDict["FHIRServerTergiTunnelToken"], os.environ['TURN_OFF_VERIFICATION_IN_REST_CALLS'])