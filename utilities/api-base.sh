#!/usr/bin/env bash
#
# Filename:     api-base.sh
#
# Description:  Build the API base URL depending on whether we are accessing
#               the public github.com or a private GitHub Enterprise server.
#

# Reset environment
export APIBASE=
export HTTPHEADERS="Accept: application/vnd.github.v3+json"

# Check if we have a valid SERVER parameter
if [ ! -n "$SERVER" ]; then
  echo -n "Enter the name of the GitHub server (i.e. github.com) and press [ENTER]: "
  read SERVER
  export SERVER=$SERVER
fi

# Determine if this is for the public github.com
if [ "$SERVER" == "github.com" ]; then
  export APIBASE="https://api.github.com";
  [[ -n "$DEBUG" ]] && printf "Checking GitHub API connectivity...";
else
  export APIBASE="https://$SERVER/api/v3";
  [[ -n "$DEBUG" ]] && printf "Checking connectivity to GitHub Enterprise at '$APIBASE'...";
fi

# Verify the endpoint is available
if curl --fail -s --connect-timeout 10 -o "/dev/null" -H "$HTTPHEADERS" $APIBASE; then
  if [ -n "$DEBUG" ]; then
    export VALIDCONN="1";
    printf "OK\n\n";
  fi
else
  export HTTPCODE=`curl -s --connect-timeout 10 -o /dev/null/ -w "%{http_code}" -H "$HTTPHEADERS" $APIBASE`;
  [[ -n "$DEBUG" ]] && echo "curl httpcode is $HTTPCODE";
  if [ "$HTTPCODE" -eq "403" ]; then
    if [[ ! -n "$AUTH" ]]; then
      printf "\nPROBLEM: You may have reached the GitHub API Rate limit. Try adding an auth token to the request with the \`-a|--auth <token>\` option.\n\n";
      exit 1;
    fi;
  else
    printf "\nERROR (api-base.sh): The provided endpoint '$APIBASE' is not valid or it cannot be reached. Please check your network connection and try again. You may also want to try the proxy option (-p|--proxy) if you are behind a corporate firewall.\n\n";
    exit 1;
  fi;
fi
