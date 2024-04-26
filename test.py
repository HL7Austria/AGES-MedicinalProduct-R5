import os

git_add_new_files = ['./input/redirects/test_redirects', './input/redirects/test_redirects.asdf']

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