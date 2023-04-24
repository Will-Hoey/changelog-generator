#!/bin/bash

# Get the remote repository URL
remote_url=$(git config --get remote.origin.url | tr -d '\n')

# Get the last n commits
n=$1
commits=$(git log --no-merges -n $n --pretty=format:'%H %s' | grep -v 'style:')

# Build the changelog
changelog="## Changelog\n\n"
while read -r commit; do
  sha=$(echo "$commit" | cut -d ' ' -f 1)
  message=$(echo "$commit" | cut -d ' ' -f 2-)
  changelog+="- $message ([${sha:0:7}](${remote_url}/commit/${sha}))\n"
done <<< "$commits"

# Open or create the CHANGELOG file
if [ -f "CHANGELOG" ]; then
  contents=$(cat CHANGELOG)
  echo -e "$changelog\n$contents" > CHANGELOG
else
  echo -e "$changelog" > CHANGELOG
fi
