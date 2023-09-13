#!/bin/bash
# config
# Config "config-variables.sh" for CHANGE test.

_configReadyCommand="asciidoctor"
_configReadyTestRepoName="$_configReadyCommand-test"
_configReadySourceUser="asciidoctor"
_configReadyOptions="declare -a _optionsToRun=('' '-o' '-D')"
_configReadyExtensions="declare -a _fileExtensions=('.adoc' '.asciidoc' '.asc' '.ad' '.md')"
_configReadyRepoClones="declare -a _fullTestRepos=('git-lfs' 'git-lfs' 'gofiber' 'fiber' 'asciidoctor' 'asciidoctor')"
_configReadyUnique="_unqUser='asciidoctor'"

sed -i "s|_COMMAND_TEST=\"command\"|_COMMAND_TEST=\"$_configReadyCommand\"|" config-variables.sh
sed -i "s|_testResultRepo=\"command-test\"|_testResultRepo=\"$_configReadyTestRepoName\"|" config-variables.sh
sed -i "s|_sourceUserName=\"source\"|_sourceUserName=\"$_configReadySourceUser\"|" config-variables.sh

sed -i "s|_repoName=\"command-repo\"\"|_repoName=\"repo-name\"|" config-variables.sh

sed -i "s|declare -a _optionsToRun=(\"\")|$_configReadyOptions|" config-variables.sh
sed -i "s|declare -a _fileExtensions=('.ext1' '.ext2' '.ext3')|$_configReadyExtensions|" config-variables.sh
sed -i "s|declare -a _fullTestRepos=('userA' 'repoA' 'userB' 'repoB' 'userC' 'repoC')|$_configReadyRepoClones|" config-variables.sh
sed -i "s|_unqUser=\"userC\"|$_configReadyUnique|" config-variables.sh

# Not using command from test root
sed -i "s|_toTestRoot=1|_toTestRoot=0|" config-variables.sh