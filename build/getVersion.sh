#!/bin/bash

source ../version
outputString=$(printf "%s.%s.%s" $major $minor $1)
echo "##teamcity[buildNumber '$outputString']"
