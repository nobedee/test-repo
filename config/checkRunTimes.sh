#!/bin/bash
# checkRunTime
# Check that the time has not gone over configured max time for extraction or build.

# extract-full-data.sh ###################
#                                        #
# Function to check extract time.        #
##########################################
function check_extract_time() {
  # check per repo extraction
  if [ $_extract_time_started = 0 ]; then
    _start_extract_time="$(date +%s.%N)" # start time of extraction
    _extract_time_started=1 # mark extraction has started
  fi
  _current_extract_time="$(date +%s.%N)" # time of extraction
  _current_extract_seconds=$(echo "$_current_extract_time - $_start_extract_time >= $_max_clone_time" | bc -l) # check if max
  if [ $_current_extract_seconds = 1 ]; then
    _whatMax="extract time"
    _closeOutExtract=1  # max time reached - close
  else
    _closeOutExtract=0 # max not reached
  fi
}

# data-test ##############################
# ---------                              #
# Function to check if max time reached. #
##########################################
function check_max_run_time() {	
  if [ $_breakOutOfTest = 1 ] && [ $_maxTimeWasReached = 1 ]; then
    _start_timing_test="$(date +%s.%N)" # reset time for next set of builds
    _breakOutOfTest=0
  else
    _current_run_time="$(date +%s.%N)" # get time since builds started
    _current_run_seconds=$(echo "$_current_run_time - $_start_timing_test >= $_max_run_time" | bc -l) # check if max
    if [ $_current_run_seconds = 1 ]; then
      _closeOutTest=1 # max time reached - close
    else
      _closeOutTest=0 # max not reached
    fi
  fi
}
