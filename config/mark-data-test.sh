#!/bin/bash
# mark-data-test
# Change the comments in data-test after the test runs so that marked steps reflect configuration.

# Change with the command that was used to build the test.
sed -i "s|-CHANGE_COMMAND-|$1|g" data-test

# Change the source username.
sed -i "s|-S_U-|$2|g" data-test

# Change the pull username.
sed -i "s|-P_U-|$3|g" data-test
