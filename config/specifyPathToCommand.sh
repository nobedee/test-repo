#!/bin/bash
# specifyPathToCommand
# Config script to determine if command will be cloned or use a local path.

# Copy the path and commands from input.
function _copyCommandFromPath() {
  if [ -e $_commandFilePath ]; then
    if [ $1 = "source" ]; then
      cp $_commandFilePath commands/$_sourceUserName-$_COMMAND_TEST/$_COMMAND_TEST
    else
      cp $_commandFilePath commands/$_pullUserName-$_COMMAND_TEST/$_COMMAND_TEST
    fi
  else
    _specifyPathToCommand "1" $1
  fi
}

# Prompt for the commands if not set in a commands folder that matches cofig structure.
function _specifyPathToCommand() {
  if [ "$1" = "1" ]; then
    echo The path was incorrect, check command\'s file path, ensuring to also enter command\'s name, and re-enter. && echo 
    read _commandFilePath
    _copyCommandFromPath $2
    _commandDirExists=1	
  fi	
  # If no commands directory then ask for path.
  if [ ! -e "commands/$_sourceUserName-$_COMMAND_TEST/$_COMMAND_TEST" ]; then
	mkdir -p commands/$_sourceUserName-$_COMMAND_TEST
    echo Clone from GitHub is turned off, and there is no command repo.
    echo Input the full path to SOURCE command, including command\'s file name.
    echo
    read _commandFilePath
    _copyCommandFromPath "source"
    _commandDirExists=1  
  elif [ ! -e "commands/$_pullUserName-$_COMMAND_TEST/$_COMMAND_TEST" ]; then
	mkdir -p commands/$_pullUserName-$_COMMAND_TEST
    echo Clone from GitHub is turned off, and there is no command repo.
    echo Input the full path to command in PULL request, including command\'s file name.
    echo
    read _commandFilePath
    _copyCommandFromPath "pull"
    _commandDirExists=1
  else
    echo 
  fi
}