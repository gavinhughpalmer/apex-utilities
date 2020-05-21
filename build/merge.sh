#!/bin/bash

while getopts s:t: option; do
    case "${option}" in
        s) SOURCE=${OPTARG};;
        t) TARGET=${OPTARG};;
    esac
done

echo "Merging to changes from $SOURCE into $TARGET..."
# reset just to ensure any changes that have been inserted at deploy time from build pipelines aren't included in the merge
git reset --hard
git config remote.origin.fetch "+refs/heads/$TARGET:refs/heads/$TARGET" 
git config remote.origin.push "refs/heads/$TARGET:refs/heads/$TARGET" 
git fetch origin 
git checkout $TARGET
git merge -X theirs $SOURCE
git push origin $TARGET