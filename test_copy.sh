#!/bin/bash

while read -r line
do
  eval $line
done < new_previous_versions_files_copy.txt