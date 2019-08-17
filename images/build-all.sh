#!/bin/bash
sh jenkins-base/build.sh
if [[ base_status -eq 0 ]]
then
    sh jenkins-master/build.sh
    master_status=$?
    sh jenkins-plugins/build.sh
    plugins_status=$?
    if [[ master_status -eq 0 && plugins_status -eq 0 ]]
    then
        echo "Master and Plugins built successfully"
        exit 0
    elif [[ master_status -eq 0 && plugins_status -ne 0 ]]
    then
        echo "Master built successfully, Plugins failed"
        exit 1
    elif [[ master_status -ne 0 && plugins_status -eq 0 ]]
    then
        echo "Plugins built successfully and Master failed"
        exit 1
    else
        echo "Master and Plugins failed"
        exit 1
    fi
else
    exit 1
fi