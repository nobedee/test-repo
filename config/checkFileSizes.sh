#!/bin/bash
# checkFileSizes
# Check that the extracted file size or the build size has not exceeded the configured amount.

# extract-full-data ########################################
# -----------------                                        #
# Function to check file size and call check_extract_time. #
############################################################
function check_file_size() {
  _current_extract_folder=$1
  _getFileSize=$(du -s -m "$_current_extract_folder" | cut -f1) # get current extraction size
  _checkFileSize=$(echo "$_getFileSize >= $_max_clone_extract" | bc -l) # check size
  if [ $_checkFileSize = 1 ]; then
    _whatMax="file size"
    _closeOutExtract=1 # max size reached - close
  else
    _closeOutExtract=0 # max not reached
    check_extract_time # check max time
  fi
}

# data-test ################################################
# ---------                                                #
# Functio to check if the built file size over config max. #
############################################################
function check_max_test_size() {
  _resetMaxSize="$1"
  if [ $_resetMaxSize = "reset" ]; then
    if [ $_breakOutOfTestSize = 1 ]; then
      _breakOutOfTestSize=0 # account for next commands' size	
    fi
    return
  else
    _current_build_folder="tests"
    if [ $_invertRepo = "pull" ]; then
      _getBuildSize=$(find "$_current_build_folder" -type f -name "*-source-*" | xargs du -ch --block-size=1M | grep total$ | cut -f1) # get current build size  
    else
      _getBuildSize=$(find "$_current_build_folder" -type f -name "*-pull-*" | xargs du -ch --block-size=1M | grep total$ | cut -f1) # get current build size  
    fi    
    _checkBuildSize=$(echo "$_getBuildSize >= $_max_test_size" | bc -l) # check size
    if [ $_checkBuildSize = 1 ]; then
      _closeOutTest=1
    else
      _closeOutTest=0
    fi  
  fi
}
