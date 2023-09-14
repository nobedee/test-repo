#!/bin/bash
# config-variables.sh
# Change the variables, and arrays to meet your test.

# Source config functions.
source config/checkIfUserAgreedExitIfNot.sh
source config/specifyPathToCommand.sh
source config/checkRunTimes.sh
source config/checkFileSizes.sh

###################################################################################
# IMPORTANT - in order to use this tool you must agree to "USAGE_AGGREEMENT.md".  #                                                                                       
#           - Changing the below variable to 1 confirms you acknowledge and agree #                                                                                         
#             and meet criteria(s) specified in "USAGE_AGREEMENT.md".             #                                                                            
#                                                                                 #       
# Acknowledgment and Agreement to "USAGE_AGREEMENT.md"                            #                                                             
# ---------------------------------------------------                             #                                                            
#                                                                                 #        
# Set to 1 to agree; 0 to disagree.                                               #
###################################################################################
_acknowledgeAndAgreeToUSAGE_AGREEMENT=0

# REQUIRED CONFIG INSTRUCTIONS: #########################################################
#  1. Define the new repo name in variable.                                             #                        
#  2. Change the config variables.                                                      #               
#  3. Define options to run with command in array and redirects.                        #                                             
#  4. Declare file extensions for files sourced in conversion in array.                 #                                                    
#  5. Change the file extension to target file extension in variable.                   #                                                  
#  6. Declare any additional repos to test tool with in array.                          #                                           
#  7. Change the unique repo for focus items of test.                                   #                                  
#  8. CHANGE COMMAND SYNTAX VARIABLE _commandSyntax <---IMPORTANT !!!!                  #                                                   
#     - If needed edit data-test file.  104 an 107.                                     #                                
#########################################################################################

# OPTIONAL CONFIG INSTRUCTIONS: #########################################################
#  1. Change max run time for both source and pull builds in run-time variable.         #                                               
#  2. Change max build size for test in run-size variable.                              #                          
#  3. Change diff commands output.                                                      #  
#########################################################################################

#######################################################################################################################
## START USER CONFIGURATION ##
#
# START REQUIRED
# ==============

# I. DEFINE NEW REPO ###################################################
# ------------------                                                   #
# Name of new repository for tests result.                             #
########################################################################
_testResultRepo="command-test"

# II. CHANGE CONFIG VARIABLES ########################################################################################
_COMMAND_TEST="command"       # command ------ the command/script that will run                                      #  
_sourceUserName="source"      # source ------- user that the repo was forked from                                    #    
_pullUserName="pull"          # pull --------- user with fork and making pull request                                #        
_repoName="repo-name"         # repo name    - the repo where command is stored for clone                            #
_toTestRoot=1                 # to test root - copies the command to test root for use, else command used in clone   # 
_exec="bin/$_COMMAND_TEST"    # exec       - path to executable for test.                                            #
                              #  IMPORTANT - only needs changing if "_toTestRoot" is 0                               #
                              #  IMPORTANT - if executable name is different, then remove variable and change name   #
_useSource=1                  # use source - Start off using source user's command. Foor time discrepencies.         # 
_cloneRepo=1                  # clone repo - 1 to clone from github, 0 to use local                                  #      
                              #  IMPORTANT - if 0 then place files in directory                                      #   
						      #             "commands/$_sourceUserName-$)COMMAND_TEST" &                             #           
						      #             "commands/$_pullUserName-$)COMMAND_TEST" manually.                       #                 
_cloneExtract=1               # clone extract - 1 to clone from github, 0 to use local                               #         
                              #     IMPORTANT - if 0 then place files in directory                                   #      
						      #             "data/extract/repo_name" where repo_name is name of repository &         #                               
						      #             "data/extract/repo_name" where repo_name is name of repository manually. #	                                        				   
                              ########################################################################################
						 
# III. DEFINE OPTIONS USED #############################################
# ------------------------                                             #
# Define options that will be used with command to test builds.        #
# By default the command will be run with no options.                  #
# Remove "" from array to unset 'run with no option default'.          #
########################################################################
declare -a _optionsToRun=("")

# IV. DECLARE SOURCE FILE EXTENSIONS ###################################
# ----------------------------------                                   #
# Configuration - file extension to match and move to data folder.     #
########################################################################
declare -a _fileExtensions=('.ext1' '.ext2' '.ext3')

# V. CHANGE FILE EXTENSION FOR TARGET FILE #############################
# ----------------------------------------                             #
# This will be the output file type for the test results.              #
########################################################################
_targetFileExtension=".html"

# VI. DECALREE ADDITIONAL REPOS TO TEST TOOL ###########################
# ------------------------------------------                           #
# Configure user(s) and repositories to clone and build ful test from. #
########################################################################
declare -a _fullTestRepos=('userA' 'repoA' 'userB' 'repoB' 'userC' 'repoC')

# VII. CHANGE UNIQUE REPO ##############################################
# -----------------------                                              #
# Specify unique user repo to make separate foler.                     #
########################################################################
_unqUser="userC"

# VIII. CHANGE COMMAND SYNTAX #####################################################
# ---------------------------                                                     #
# IMPORTANT - DO NOT CHANGE ELEMENTS - ONLY HOW IT WILL BE CALLED IN COMMAND LINE #                                  
#             If needed edit data-test file.  104 an 107.                         #          
# Note - keep variables, and note that $opts is for each option in array.         #                          
# Note - data/"$_curDir"/"$line" - is the input file                              #     
# Note - tests/"$_curData"/"$line"-"$1""$_nameOpt".html - will be output file     #
# IMPORTANT - this configuration assumes you intermediate scripting knowledge.    #
###################################################################################
function _commandSyntax() {
  ###################################################################
  # IMPORTANT - do not change elements. only how command is called. #
  #             If needed edit data-test file.  136 and 140.        #
  ###################################################################
  # option      # file to change   # file that is changed
  _opt="$1" && _inputFile="$2" && _outputFile="$3"
  
  # EXAMPLE: #######################################
  # command opts inputfile > output file           #        
  #                                                #            
  # Any additional lines. If needed edit data-test #
  ##################################################
  # The below syntaxs are configurred for ROFFIT and ASCIIDOCTOR respectively.
  if [ $_toTestRoot = 1 ]; then 
    # EXAMPLE CONFIGURATION FOR ROFFIT
    # DO NOT CHANGE - variables (well remove "<" and ">" if needed).
    # BUT REARRANGE - varibales per command syntax. This is configurred for roffit.
    ./$_COMMAND_TEST "$_opt" < "$_inputFile" > "$_outputFile"
  else
    # EXAMPLE CONFIGURATION FOR ASCIIDOCTOR
    # DO NOT CHANGE - variables - changed in data-test.
    #    IMPORATANT - if needed make changes in "data-test".
    # BUT REARRANGE - pending on how syntax of command is used.
    # AND MAKE IF CHANGE - some uses require custom syntax per option. Below is configurred to asciidoctor.
    if [ "$_opt" = "" ]; then
      commands/"$_curUser"-"$_COMMAND_TEST"/"$_exec" "$_inputFile"
      _moveHTML="${_inputFile%.*}$_targetFileExtension" && mv "$_moveHTML" "$_outputFile"
    elif [ "$_opt" = "-D" ]; then
      _moveHTML="${_outputFile%/*}" && _inputFileName="${_inputFile##*/}" && _outputFileName="${_inputFileName%.*}.html"
      commands/"$_curUser"-"$_COMMAND_TEST"/"$_exec" "$_opt" "$_moveHTML" "$_inputFile"
      _renameHTML="$_moveHTML/${_inputFileName%.*}$_targetFileExtension" && mv "$_renameHTML" "$_outputFile"
    elif [ "$_opt" = "-o" ]; then
      commands/"$_curUser"-"$_COMMAND_TEST"/"$_exec" "$_opt" "$_outputFile" "$_inputFile"
    fi
  fi

}

# END REQUIRED
# ============
# ======================================


# START OPTIONAL
# ==============

# SECONDS - Max number of seconds each command has to run test.
_max_run_time=600
# MB - Max size the test can build with both commands.
_max_test_size=20

# MB - Max size that each cloned repo can extract
_max_clone_extract=50
# SECONDS - Max time that each cloned repo can extract
_max_clone_time=900


# Syntax for how the "diff" command will be used.
_diffCommand="diff"

# END OPTIONAL
# ============
# ==========================================

## END USER CONFIGURATION ##
############################
#######################################################################################################################
#######################################################################################################################



#######################################################################################################################
## START CONFIGURATION SCRIPTS ##########################
#  ---------------------------                          #
#  NOTE - the below lines are not inteded to be edited. #
#         only edit if you know what you're doing.      #
#########################################################

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
###############################
#######################################################################################################################
#######################################################################################################################