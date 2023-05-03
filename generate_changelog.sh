#!/bin/bash

# Function to display usage instructions
function usage() {
  echo "Usage: $0 [-n num_commits] [-o output_file]"
  exit 1
}

# Parse command line options
while getopts "n:o:" opt; do
  case $opt in
    n)
      num_commits="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    *)
      usage
      ;;
  esac
done

# Get the remote repository URL
remote_url=$(git config --get remote.origin.url | tr -d '\n')

# Get the last n commits or all since
if [ -z "$num_commits" ]; then
  commits=$(git log --no-merges --invert-grep --grep='^style:' --pretty=format:'%H %s' $(git log -n 1 origin/develop --pretty=format:'%H')..HEAD)
else
  commits=$(git log --no-merges --invert-grep --grep='^style:' -n $num_commits --pretty=format:'%H %s')
fi

# Build the changelog
changelog="## Changelog\n\n"
while read -r commit; do
  sha=$(echo "$commit" | cut -d ' ' -f 1)
  message=$(echo "$commit" | cut -d ' ' -f 2-)
  changelog+="- $message ([${sha:0:7}](${remote_url}/commit/${sha}))\n"
done <<< "$commits"

# Output the changelog
if [ -z "$output_file" ]; then
  echo -e "$changelog"
else
  if [ -f "$output_file" ]; then
    contents=$(cat "$output_file")
    echo -e "$changelog\n$contents" > "$output_file"
  else
    echo -e "$changelog" > "$output_file"
  fi
fi