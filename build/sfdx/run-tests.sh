#!/bin/bash

# Exit if a failure occurs so that errors are surfaced in the deployment tool
set -e

sfdx force:lightning:lint ./force-app/main --exit --verbose

export SFDX_USE_PROGRESS_BAR=false

echo "Creating the Scratch Org..."
sfdx force:org:create --definitionfile config/project-scratch-def.json --setalias TestRunner --durationdays 1
hasError=false
{
    echo "Pushing source code..." &&
    sfdx force:source:push --targetusername TestRunner --forceoverwrite &&

    echo "Running unit tests..." &&
    sfdx force:apex:test:run --testlevel RunLocalTests --outputdir test-results --resultformat tap --targetusername TestRunner --codecoverage --wait 10

} || {
    hasError=true
}
sfdx force:org:delete --noprompt --targetusername TestRunner

if $hasError; then
    exit 1
fi
