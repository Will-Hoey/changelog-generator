# Changelog generator script

This Bash script generates a changelog by fetching a specified number of commits from the current branch (excluding merge commits and commits with the prefix "style") and inserting them into a file called `CHANGELOG`.

## Prerequisites

To use this script, you need to have Git installed on your machine. You can download Git from the [official website](https://git-scm.com/downloads).

## Installation

To use this script, you will need to clone this repository to your local machine. You can do this by running the following command in your terminal:

```
git clone https://github.com/Will-Hoey/changelog-generator/
```

Once you have cloned the repository, navigate to the root directory of the project and make the script executable by running the following command:

```
chmod +x generate_changelog.sh
```

## Usage

To generate a changelog, run the following command:

```
./generate_changelog.sh [-n <number_of_commits>]
```

The `-n` option is optional. If it is not supplied, the script will assume that you want to pull all commits until the current HEAD on develop. If it is supplied, it should be followed by the number of commits you want to include in the changelog.

For example, to generate a changelog of the last 10 commits, you would run:

```
./generate_changelog.sh -n 10
```

The generated changelog will be inserted at the top of the `CHANGELOG` file. If the file does not exist, it will be created.


## Setting an alias

A better method for running this script is to create an alias. The method in which you setup an alias will vary depending on what shell you are using.

Bash:

	$ alias_name="bash /path/to/script/generate_changelog.sh"


Fish:

	 alias -s alias_name="bash /path/to/script/generate_changelog.sh"
