#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Project name can't be empty"
    exit 1
fi

project="$1"

mv "src/lib/app_name.ex" "src/lib/${project}.ex";
mv "src/lib/app_name_web.ex" "src/lib/${project}_web.ex";
mv "src/lib/app_name" "src/lib/${project}";
mv "src/lib/app_name_web" "src/lib/${project}_web";
mv "src/test/app_name_web" "src/lib/${project}_web";

IFS='_' read -r -a array <<< "$project"

pascalProject=""
for element in "${array[@]}"
do
    element="$(tr '[:lower:]' '[:upper:]' <<< ${element:0:1})${element:1}"
    pascalProject="${pascalProject}${element}"
done

LC_ALL=C find ./src -type f -exec sed -i '' -e "s/app_name/${project}/" {} \;
LC_ALL=C find ./src -type f -exec sed -i '' -e "s/AppName/${pascalProject}/" {} \;
