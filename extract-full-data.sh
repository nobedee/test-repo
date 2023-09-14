#!/bin/bash
# extract-full-data.sh
# Clone repositories specified in "_fullTestRepos" by username and repositroy
# to the full-test directory to test a data-conversion-tool pull request.

##########################################################
################## EXTRACT-FULL-DATA #####################
### All files in this repositroy are public domain cc0 ###
### Any files created by the test are subject to the   ###
### license specified in that reposityor.              ###
##########################################################

### 1. SET CONFIGURATION AND READY DATA TO BE EXTRACTED. ##################################################################
###########################################################################################################################
# Set variables from config-variables.sh. 
# IMPORTANT - these should have been changed after making repo from template.
# IMPORTANT - you must agree to terms before use.
source config-variables.sh
check_if_user_agreed_exit_if_not # check if agreed to terms, exit if not

# Used to check and reset time, and check paths of each repo extracts.
_extract_time_started=0 # DO NOT CHANGE
_closeOutExtract=0 # DO NOT CHANGE
_copyingExtract=0 # DO NOT CHANGE - when cloning is turned off for extract repos

# Make temp extract location.
mkdir -p data/extract data/full-test 2>/dev/null

# Directory where repos will be cloned, extracted, then deleted.
_startingDir="data/extract" # clone and extract here


### 2. DETERMINE, THEN CLONE REPOSITORIES FROM CONFIGURATION. #############################################################
###########################################################################################################################
# Function check for exract file if cloning from GitHub turned off.
function get_extract_path() {
  _curRepo=$1
  if [ ! -e data/extract/$_curRepo ]; then
    echo "Path not found. Please enter full path to folder $_curRepo"
    _copyingExtract=1
    echo && read _currentExtractPath
  else
    _copyingExtract=0
  fi
}

# Function to process directories recursively
function process_directory() {
  # clone to data/extract
  dir="$1"
  # username where repo is hosted
  _curUser="$2"
  # if functio  not recursing
  if [ "$_curUser" != "0" ]; then
    # repo name to clone
    _curRepo="$3"
    dir="$1/$_curRepo"
    # check if user is set for outputting to unq folder
    if [ "$_curUser" == "$_unqUser" ]; then
      _outPutDir="data/full-test/unq"
    else
      _outPutDir="data/full-test/gen"
    fi
    # make directory to extract to
    mkdir -p $_outPutDir/$_curRepo
    _runCloneOrCopyForExtract=1
  fi
  # clone to data/extract where it will be deleted after funciton run
  _clone_or_copy_for_extract() {
    if [ $_cloneExtract = 1 ]; then
      git clone https://github.com/$_curUser/$_curRepo.git data/extract/$_curRepo
    else
      echo "Clone from test files from GitHub is turned off."
      get_extract_path "$_curRepo"
      if [ $_copyingExtract = 1 ]; then
        if [ -e $_currentExtractPath ]; then
        cp -r $_currentExtractPath data/extract/$_curRepo
      else
        echo Path was incorrect. Please re-enter path.
        get_extract_path $_curRepo
        _clone_or_copy_for_extract
      fi
    fi          
  fi
  _runCloneOrCopyForExtract=0
  }
  if [ $_runCloneOrCopyForExtract = 1 ]; then
    _clone_or_copy_for_extract
  fi


### 3. EXTRACT FILES MATCHING CONFIGURED EXTENSIONS IN ` CONFIG-VARIABLES.SH ` TO DATA/FULL-TEST DIRECTORY. ###############
###########################################################################################################################
# loop and extract files matching extension or recurse
  _duplicateCount=1 # for duplicate files in repos
  for entry in "$dir"/*; do
    # check that max size has not been reached
    check_file_size "$_outPutDir/$_curRepo" # calls both
    if [ $_closeOutExtract = 1 ]; then
      echo "Max $_whatMax has been reached."
      break
    fi
    # current iteration is a file
    if [ -f "$entry" ]; then
      # loop extensions and check if file matches it
      for ext in "${_fileExtensions[@]}"; do
      # if a match move to data/full-test/[gen | unq]
      if [[ "$entry" == *"$ext" ]]; then
        _fileName="${entry##*/}"
        if [ -e "$_outPutDir/$_curRepo/$_fileName-$_user-$_repo" ]; then
          cp "$entry" "$_outPutDir/$_curRepo/$_fileName-$_user-$_repo-$_duplicateCount$ext" 2>/dev/null # duplicate file names
          _duplicateCount=$(( _duplicateCount + 1 ))
        else
          cp "$entry" "$_outPutDir/$_curRepo/$_fileName-$_user-$_repo$ext"    # copy files
        fi
        echo "Copied: $entry"                  # stdout copied
        break                                  # end ext. loop
      fi
    done
    elif [ -d "$entry" ]; then # recurse			
      process_directory "$entry" "0" "0"
    fi
  done
}


### 4. PROMPT TO CONFIRM THEN RUN FUNCTION TO EXTRACT DATA.	 ##############################################################
###########################################################################################################################
# Alert on long script runtime.
echo Script has begun recursing. 
echo \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#  && echo 
echo This may take a while. Est. time - 15 minutes.
echo Continue \[Y/n\]: && echo 
# User response to confirm or not functionrun.
read -r _response

# Start processing from the starting directory if responded yes[Y]
if [ "$_response" = "Y" ]; then
  index=0

  # loop through user/repo array respectively passing 
  # user and repo as arguments, incrementing by 2
  while (( index < ${#_fullTestRepos[@]} - 1 )); do
    _user=${_fullTestRepos[index]}     # even index
    _repo=${_fullTestRepos[index + 1]} # odd index
    process_directory "$_startingDir" "$_user" "$_repo"
    if [ $_cloneExtract = 1 ]; then
      rm -rf "data/extract/$_repo"
    fi
    # reset starting extract time
    _extract_time_started=0
    # increment index by 2
    index=$((index + 2))
  done
else
  # if user response is "n"
  echo Script did not run. Batch will now clean and exit.
fi

# Move files to parent test folders.
mv data/full-test/gen/*/* data/full-test/gen
mv data/full-test/unq/*/* data/full-test/unq
# Remove extract folders.
rmdir data/full-test/gen/*/ data/full-test/unq/*/
	
# Clean after extraction if using GitHub clone.
if [ $_cloneExtract = 1 ]; then
  rm -rf data/extract
fi
