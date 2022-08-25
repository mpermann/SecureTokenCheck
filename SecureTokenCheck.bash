#!/bin/bash

# Name: SecureTokenCheck.bash
# Version: 1.0
# Created: 08-24-2022 by Michael Permann
# Updated: 08-24-2022
# The script is for checking whether a specific user account has a secure token. If the result contains
# the provided username along with the unique ID, then the account has a secure token and will 
# appear at the FileVault unlock screen. This is undesired behavior, so the script removes the secure token.

ACCOUNT_TO_CHECK=$4
SECURE_TOKEN_STATUS=$(fdesetup list | grep $ACCOUNT_TO_CHECK)

if [ -n "$SECURE_TOKEN_STATUS" ] # Check whether result of command string length is non-zero.
then
    # Since SECURE_TOKEN_STATUS string length is non-zero, the account has a secure token.
    echo $SECURE_TOKEN_STATUS
    fdesetup remove -user $ACCOUNT_TO_CHECK
    echo $(fdesetup list | grep $ACCOUNT_TO_CHECK)
    exit 1 # Exit 1 so policy execution appears to fail in Jamf Pro to highlight remediated computers
else
    # Since SECURE_TOKEN_STATUS string length is zero, the account does not have a secure token.
    exit 0
fi
