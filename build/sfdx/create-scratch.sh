#!/bin/bash

set -e

ALIAS=$1

echo "Creating the Scratch Org ${ALIAS}..."
sfdx force:org:create --definitionfile config/project-scratch-def.json --setalias ${ALIAS} --durationdays 30 --setdefaultusername

echo "Pushing Source..."
sfdx force:source:push --targetusername ${ALIAS} --forceoverwrite

echo "Assigning Permission Sets..."
permissionSetExtension=".permissionset-meta.xml"
for fileName in $(find force-app -name "*$permissionSetExtension"); do
    permissionSetPath=${fileName%"$permissionSetExtension"}
    permissionSet=${permissionSetPath##*/}
    sfdx force:user:permset:assign --permsetname $permissionSet --targetusername ${ALIAS}
done

osascript -e "display notification \"Scratch org setup completed\""