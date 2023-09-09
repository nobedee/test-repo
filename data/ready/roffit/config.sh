#!/bin/bash
# config
# Config "config-variables.sh" for roffit test.

_configReadyCommand="roffit"
_configReadySourceUser="bagder"
_configReadyOptions="declare -a _optionsToRun=(\"\" \"--bare\")"
_configReadyExtensions="declare -a _fileExtensions=('.1' '.3' '.8' '.1.in')"
_configReadyRepoClones="declare -a _fullTestRepos=('nmap' 'nmap' 'libssh2' 'libssh2' 'curl' 'curl')"
_configReadyUnique="_unqUser\=\"curl\""

sed -i "s|_COMMAND_TEST=\"command\"|_COMMAND_TEST=\"$_configReadyCommand\"|" config-variables.sh
sed -i "s|_sourceUserName=\"source\"|_sourceUserName=\"$_configReadySourceUser\"|" config-variables.sh

sed -i "s|_repoName=\"command-repo\"|_repoName=\"repo-name\"|" config-variables.sh

sed -i "s|declare -a _optionsToRun=(\"\")|$_configReadyOptions|" config-variables.sh
sed -i "s|declare -a _fileExtensions=('.ext1' '.ext2' '.ext3')|$_configReadyExtensions|" config-variables.sh
sed -i "s|declare -a _fullTestRepos=('userA' 'repoA' 'userB' 'repoB' 'userC' 'repoC')|$_configReadyRepoClones|" config-variables.sh
sed -i "s|_unqUser=\"userC\"|$_configReadyUnique|" config-variables.sh
