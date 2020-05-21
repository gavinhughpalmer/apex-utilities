#!/bin/bash

BRANCH=$1

git checkout -b "feature/${BRANCH}"

./build/sfdx/create-scratch.sh $BRANCH