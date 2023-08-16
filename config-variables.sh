#!/bin/bash
# config-variables.sh
# Change the variables, and arrays to meet your test.

# Define command, username for pulled command, source username, and default _useSource to 1.
# IMPORTANT - this assumes that the repo name is still roffit,
#             and has not been changed to anything else.
_COMMAND_TEST="roffit"   # command that will run
_sourceUserName="bagder" # source - user repo was forked from
_pullUserName="jhauga"   # pull - user making pull request
_useSource=1             # Start off using source user's command

# Define options that will be used with command to test builds.
# By default the command will be run with no options.
# Remove "" from array to unset 'run with no option default'.
declare -a _optionsToRun=("" "--bare")

# Configuration - file extension to match and move to data folder.
declare -a _fileExtensions=('.1' '.3' '.8' '.1.in')

# Configure user(s) and repositories to clone and build ful test from.
declare -a _fullTestRepos=('nmap' 'nmap' 'libssh2' 'libssh2' 'curl' 'curl')

# Name of test result repo. This is for test link in README.md
_testResultRepo="roffit-pull-diff"