#!/bin/bash
# askClone
# Ask if local commands are used or if cloning from GitHub.

read _areCommandsCloned
if [ -e data/ready/.noGitHubClone ]; then
  rm data/ready/.noGitHubClone
fi
if [ $_areCommandsCloned = "n" ]; then
  touch data/ready/.noGitHubClone
fi
