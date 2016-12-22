#!/usr/bin/env bash
#
# Filename:     get-collaborators.sh
#
# Description:  Get a list of collaborators for the specified
#               GitHub OWNER/REPO (REPO is optional).
#

# +---------------------------------------------------------------------------+
# | Set Attribute(s) for the GitHub Admin Toolkit.                            |
# +---------------------------------------------------------------------------+
GITHUB_ADMIN_DESC="Description for get-collaborators."
GITHUB_ADMIN_ENABLED=1

# +---------------------------------------------------------------------------+
# | We need a minimum set of params before we can continue. REPO is optional. |
# +---------------------------------------------------------------------------+

# Check that we have a SERVER to connect to
if [ ! -n "$SERVER" ]; then
  printf "\nERROR ($0): No server was specified to connect to."
  RC=2  # Return code
fi

# Check that we have an OWNER to work with
if [ ! -n "$OWNER" ]; then
  printf "\nERROR ($0): No owner was specified."
  RC=2  # Return code
fi

# Exit with error if something isn't right. Proceed if we are good
[ "$RC" -ne 0 ] && usage && exit $RC

# +---------------------------------------------------------------------------+
# | Perform work.                                                             |
# +---------------------------------------------------------------------------+
echo " "
echo "The collaborators are:"
echo " "
echo "  CollabA"
echo "  CollabB"
echo "  CollabC"
