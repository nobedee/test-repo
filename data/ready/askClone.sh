#!/bin/bash

read _areCommandsCloned
if [ -e data/ready/.noGitHubClone ]; then
  rm data/ready/.noGitHubClone
fi
if [ $_areCommandsCloned = "n" ]; then
	touch data/ready/.noGitHubClone
fi
