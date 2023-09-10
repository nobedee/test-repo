#!/bin/bash
# config-variables.sh
# Change the variables, and arrays to meet your test.

# Source config functions.
source config/checkIfUserAgreedExitIfNot.sh
source config/specifyPathToCommand.sh

# IMPORTANT - in order to use this tool you must agree to "USAGE_AGGREEMENT.md".
#           - Changing the below variable to 1 confirms you acknowledge and agree 
#             and meet criteria(s) specified in "USAGE_AGREEMENT.md".

# Acknowledgment and Agreement to "USAGE_AGREEMENT.md"
# ---------------------------------------------------
#
# Set to 1 to agree; 0 to disagree.
_acknowledgeAndAgreeToUSAGE_AGREEMENT=0

# REQUIRED CONFIG INSTRUCTIONS:
#  1. Define the new repo name in variable.
#  2. Change the config variables.
#  3. Define options to run with command in array and redirects.
#  4. Declare file extensions for files sourced in conversion in array.
#  5. Change the file extension to target file extension in variable.
#  6. Declare any additional repos to test tool with in array.
#  7. Change the unique repo for focus items of test.
#  8. CHANGE COMMAND SYNTAX VARIABLE _commandSyntax <---IMPORTANT !!!!
#     - If needed edit data-test file.  104 an 107.
#########################################################################################
#
# OPTIONAL CONFIG INSTRUCTIONS:
#  1. Change max run time for both source and pull builds in run-time variable.
#  2. Change max build size for test in run-size variable.
#  3. Change diff commands output
#########################################################################################

#########################################################################################
## START USER CONFIGURATION ##

############################################
# START REQUIRED

# I. DEFINE NEW REPO
# Name of new repository for tests result. 
_testResultRepo="command-test" 

# II. CHANGE CONFIG VARIABLES
_COMMAND_TEST="command"  # command ------ the command/script that will run
_sourceUserName="source" # source ------- user that the repo was forked from
_pullUserName="pull"     # pull --------- user with fork and making pull request
_repoName="command-repo" # command-repo - the repo where command is stored for clone
_useSource=1             # use source - Start off using source user's command
_cloneRepo=1             # clone repo - 1 to clone from github, 0 to use local
                           # IMPORTANT - if 0 then place files in directory 
						   #             "commands/$_sourceUserName-$)COMMAND_TEST" &
						   #             "commands/$_pullUserName-$)COMMAND_TEST" manually.

# III. DEFINE OPTIONS USED
# Define options that will be used with command to test builds.
# By default the command will be run with no options.
# Remove "" from array to unset 'run with no option default'.
declare -a _optionsToRun=("")

# IV. DECLARE SOURCE FILE EXTENSIONS
# Configuration - file extension to match and move to data folder.
declare -a _fileExtensions=('.ext1' '.ext2' '.ext3')

# V. CHANGE FILE EXTENSION FOR TARGET FILE
_targetFileExtension=".html"

# VI. DECALREE ADDITIONAL REPOS TO TEST TOOL
# Configure user(s) and repositories to clone and build ful test from.
declare -a _fullTestRepos=('userA' 'repoA' 'userB' 'repoB' 'userC' 'repoC')

# VII. CHANGE UNIQUE REPO
# Specify unique user repo to make separate foler.
_unqUser="userC"

# VIII. CHANGE COMMAND SYNTAX
# IMPORTANT - DO NOT CHANGE ELEMENTS - ONLY HOW IT WILL BE CALLED IN COMMAND LINE
#             If needed edit data-test file.  104 an 107.
# Note - keep variables, and note that $opts is for each option in array.
# Note - data/"$_curDir"/"$line" - is the input file
# Note - tests/"$_curData"/"$line"-"$1""$_nameOpt".html - will be output file

_commandSyntax() {
  # IMPORTANT - do not change elements. only how command is called.
  #             If needed edit data-test file.  104 an 107.
  
  _opt="$1" && _inputFile="$2" && _outputFile="$3"
  ./$_COMMAND_TEST "$_opt" < "$_inputFile" > "$_outputFile"

  # EXAMPLE:
  # command opts inputfile > output file
  
  # Any additional lines. If needed edit data-test
}

# END REQUIRED
############################################
############################################


############################################
# START OPTIONAL

# Max number of seconds each command has to run test.
_max_run_time=120

# Max size the test can build with both commands.
_max_test_size=10000000

# Syntax for how the "diff" command will be used.
_diffCommand="diff"

# END OPTIONAL
############################################
############################################
## END USER CONFIGURATION ##
#########################################################################################
#########################################################################################



#########################################################################################
## START CONFIGURATION SCRIPTS ##
# NOTE - the below lines are not inteded to be edited.
#        only edit if you know what you're doing.


# Condition to check if using GitHub ot local files.
if [ $_cloneRepo = 0 ]; then
  touch .localCommandUsed  
  _specifyPathToCommand
else
  rm .localCommandUsed nul 2>nul
  if [ -e commands ]; then
    rm -rf commands
  fi
fi

## END CONFIGURATION SCRIPTS ##
#########################################################################################
#########################################################################################