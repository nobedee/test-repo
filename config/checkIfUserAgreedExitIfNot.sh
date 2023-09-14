#!/bin/bash
# checkIfUserAgreedExitIfNot
# Check the agreement status and output message if not agreed.

# Exit if _acknowledgeAndAgreeToUSAGE_AGREEMENT is 0
function check_if_user_agreed_exit_if_not() {
  if [ "$_acknowledgeAndAgreeToUSAGE_AGREEMENT" = 0 ]; then
    echo YOU HAVE NOT AGREED TO TERMS OR HAVE NOT CHANGED _acknowledgeAndAgreeToUSAGE_AGREEMENT VARIABLE
    echo \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
    echo 
    echo Before using you must agree to the usage agreement and change _acknowledgeAndAgreeToUSAGE_AGREEMENT variable.
    echo The _acknowledgeAndAgreeToUSAGE_AGREEMENT variable is on 
    echo \*\* line 13 \*\*
    echo
    echo To do so manually change the variaable "_acknowledgeAndAgreeToUSAGE_AGREEMENT" to 1 on.
    echo \*\* line 13 \*\*
    echo
    echo Or run "./agree" in the terminal. Then rerun make.
    echo
    exit 
  fi
}
