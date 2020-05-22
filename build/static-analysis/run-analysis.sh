#!/bin/bash

# Exit if a failure occurs so that errors are surfaced in the deployment tool
set -e

echo "Running analysis on apex classes..."
# TODO Reformat the output results so that BitBucket can register them
pmd -d ./force-app/ -R "${BASH_SOURCE%/*}/apex-ruleset.xml" -f text -l apex -cache ~/pmd-cache

echo "Checking for any copy and paste code..."
cpd --minimum-tokens 100 --files ./force-app/ --language apex --exclude ./force-app/main/dnb-integration-credit-check/classes/DnbWebService.cls