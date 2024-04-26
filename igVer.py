import os
import re
import csv
from datetime import datetime, timezone
from subprocess import Popen, PIPE, STDOUT
from pathlib import Path
from shutil import copyfile
from file_name_and_extension_extractor import *

def create_tag(tag_name, version):
    if tag_name:
        print('remove and add tag for ' + tag_name)
        # remove tag
        os.system('git tag -d ' + tag_name)
        # add tag
        os.system('git tag -a ' + tag_name + ' -m "' + version + '"')

def read_terminologies_metadata(file_name):
    resources_dict = {}
    with open(file_name, 'r', newline='') as csvfile:
        csv_reader = csv.DictReader(csvfile, delimiter=',')
        for one_row in csv_reader:
            if one_row['name']:
                resources_dict[one_row['name']] = {'oid': one_row['oid'], 'version': one_row['version'], 'type': one_row['type'], 'id': one_row['id']}
    return resources_dict

# read list of terminologies that have been processed by MaLaC-CT
processed_resources_dict = read_terminologies_metadata('processedTerminologies.csv')
# read list of all terminologies that have been present the last time of a successful pipeline run
old_resources_dict = read_terminologies_metadata('old_terminologiesMetadata.csv')

# read the Terminologit's current commit's full hash
with open('currentCommit.txt', 'r') as file:
    current_commit_sha = file.read()
print('commit sha for current commit: ' + current_commit_sha)

# current date / time will be used to prepend all versioned files with that timestamp
# note: this date is not related to the terminologies in any way.
current_datetime = datetime.now(timezone.utc).strftime('%Y%m%d-%H%M%S-')
print('current datetime: ' + current_datetime)

# make sure includes and redirects directories exists
Path('../../input/includes/').mkdir(parents=True, exist_ok=True)
Path('../../input/redirects/CodeSystem/').mkdir(parents=True, exist_ok=True)
Path('../../input/redirects/ValueSet/').mkdir(parents=True, exist_ok=True)

download_base = 'https://gitlab.com/' + os.environ['CI_PROJECT_PATH'] + '/-/raw/' + current_commit_sha.strip('"')

print('-------- processed_resource_dict --------')
print(processed_resources_dict)

git_add_new_files=[]

# for every processed resource
for resource_name in processed_resources_dict.keys():
    # create/alter previous version file only if
    # - the resource was not present in the old_resources_dict, i.e. it is a new resource
    # OR
    # - the resource's version has changed
    if resource_name not in old_resources_dict or old_resources_dict[resource_name]['version'] != processed_resources_dict[resource_name]['version']:
        print('next resource to be versioned is: ' + resource_name)

        # file path to the list of previous versions
        previous_versions_file = '../../input/includes/' + resource_name + '-previous-versions.xhtml'
        # create list of previous versions if it does not exist
        if not os.path.exists(previous_versions_file):
            print('creating new previous-version file')

            # create previous versions file
            with open(previous_versions_file, 'w', encoding='utf-8') as file_name:
                file_name.writelines('<table class="grid">\r\n<tr><td><b>Version Number</b></td><td><b>Current Version vs. Outdated Version</b></td></tr>\r\n</table>')
            # store file path to new previous version file; '../.' are being skipped from path in order to properly use that information for a git commit later
            git_add_new_files.append(previous_versions_file[4:])

            # create redirects file
            redirects_file_path = '../../input/redirects/' + processed_resources_dict[resource_name]['type'] + '/' + processed_resources_dict[resource_name]['id'] + '.html'
            with open(redirects_file_path, 'w', encoding='utf-8') as redirects_file:
                redirects_file.writelines('<!DOCTYPE html> <html> <head> <meta http-equiv="refresh" content="0; url=\''+ os.environ['TERMGIT_CANONICAL'] + '/' + resource_name + '.html' +'\'" /> </head> </html>')
            # store file path to new redirects file; '../.' are being skipped from path in order to properly use that information for a git commit later
            git_add_new_files.append(redirects_file_path[4:])

        else:
            print('updating existing previous-version file')

            # Create entry in previousVersionsFile only if an old version already exists within the HTML project. It might happen that a new terminology
            # has been added within a branch that was not the default branch. Then the previous-versions file has been created. At the time of merging
            # this development branch into the default branch no entry would be necessary as the terminology would be published for the first time.
            if os.path.exists(resource_name + '.html'):
                with open(previous_versions_file, 'r', encoding='utf-8') as file_name:
                    lines = file_name.readlines()

                # remove last line containing end of table '</table>'
                lines = lines[:-1]
                # add line with link to last published version and possibility to create diff
                lines.append('<tr>' +
                '<td><a href="' + current_datetime + resource_name + '.html">' + old_resources_dict[resource_name]['version'] + '</a></td>' +
                '<td><a onclick="createDiff(\'' + resource_name + '.html\', \'' + current_datetime + resource_name + '.html\')" href="javascript:void(0);">Diff</a></td>' +
                '</tr>\r\n')
                # terminate table
                lines.append('</table>')

                # save it under ../../input/includes
                with open(previous_versions_file, 'w', encoding='utf-8') as file_name:
                    file_name.writelines(lines)

                # change the links in all unversioned htmls and write the banner into the html and rename all the files without a date
                for file_name in Path('.').rglob('*'):
                    if not re.match(r'\d{8}-\d{6}-.+', file_name.name) and not file_name.name.endswith('.previous-versions.html') and file_name.name.startswith(resource_name + '.'):
                        if file_name.name.endswith('.html'):
                            # read the whole file
                            with open(file_name,'r',encoding='utf-8') as file:
                                file_content = file.read()

                            # change link to narrative
                            file_content = file_content.replace(resource_name + '.html',current_datetime + resource_name + '.html')
                            # change download link
                            file_content = file_content.replace(resource_name + '.download.html',current_datetime + resource_name + '.download.html')
                            # add banner
                            banner = '<div role="alert" class="alert alert-danger"><p id="publish-box">This is an outdated version that is no longer valid! You can access the <a href=' + resource_name + '.html>current version here</a>.</p></div>'
                            file_content = file_content.replace('<ul class="nav nav-tabs">', banner + '<ul class="nav nav-tabs">')

                            # save file
                            with open(file_name, 'w', encoding='utf-8') as file:
                                file.write(file_content)

                        # rename file
                        os.rename(file_name.name, current_datetime + file_name.name)

    # in any case the downloads-page for a resource has to be created anew
    print('creating downloads for the following ressource: ' + resource_name)
    with open('../../input/includes/' + resource_name + '-download.xhtml', 'w') as file:
        download_resource_base = download_base + '/terminologies/' + resource_name + '/' + resource_name
        print('download_resource_base: ' + download_resource_base)

        file.writelines('<table class="grid">\r\n')
        for implemented_format, implemented_format_metainfo in implemented_file_formats.items():
            file.writelines('<tr><td><a href="' + download_resource_base + implemented_format + '?inline=false">download ' + implemented_format_metainfo[0] + '</a></td><td><a target="_blank" rel="noopener noreferrer" href="' + download_resource_base + implemented_format + '">raw ' + implemented_format_metainfo[0] + ' (from GitLab)</a></td><td>' + implemented_format_metainfo[1] + '</td></tr>\r\n')

        file.writelines('</table>')

# move all versioned files to the old directory
# move all *zuppl* files to the old directory - Zuppl files are legacy and are no longer supported. However, they will be preserved in order to have functional old versions (the reference Zuppl terminologies)
for file_name in Path('.').rglob('*'):
    if re.match(r'\d{8}-\d{6}-.+', file_name.name) or re.match(r'.*zuppl.*', file_name.name):
        copyfile(file_name.name, '../../old/' + file_name.name)

# change into root directory (= terminologit repository) in order to be able
# - to (re-)set the tags of the changed terminologies accordingly (if on default branch)
os.chdir('../..')

# job will only run if commit branch is on default branch and if there are resources that have been changed
if os.environ['CI_COMMIT_BRANCH'] == os.environ['CI_DEFAULT_BRANCH'] and len(processed_resources_dict) > 0:
    # add/update tags for every changed resource
    for resource_name in processed_resources_dict.keys():
        # create Git tag for resource name
        create_tag(resource_name, processed_resources_dict[resource_name]['version'])
        # create Git tag for resource's OID
        create_tag(processed_resources_dict[resource_name]['oid'], processed_resources_dict[resource_name]['version'])

    # push the tags
    print('pushing tags')
    os.system('git push -f --tags "https://' + os.environ['GITLAB_USER_LOGIN'] + ':' + os.environ['GITLAB_CI_TOKEN'] + '@gitlab.com/' + os.environ['CI_PROJECT_PATH'] + '.git"')

# write the file paths of the new created previous version files for them to be commited later
with open('new_previous_versions_files.txt', 'w') as file:
    file_lines = ' '.join(git_add_new_files)
    print('new previous versions files: ' + file_lines)
    file.write(file_lines)

# create a file which will late copy the created redirects back to input/redirects in order to be commited properly
with open('copy_created_redirects.txt', 'w') as file:
    command_list = []
    for file_name in git_add_new_files:
        if 'redirects' in file_name:
            command = 'cp -v ' + file_name.replace('./input/redirects', './old') + ' ' + file_name
            print('command to re-copy redirect file to be committed: ' + command)
            command_list.append(command)
    # write an extra empty line in order for shell-loop executed lated to work as intended
    file.write(' && '.join(command_list))
    file.write('\n')
