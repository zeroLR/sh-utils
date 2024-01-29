#!/bin/bash

source .env

ENV_KEYS=(
    VARIABLE_1
    VARIABLE_2
    VARIABLE_3
)

# Check required environment variable existed
for key in "${ENV_KEYS[@]}"
do
  if [ -z "${!key}" ]
  then
    echo "Required ENV_KEY: $key"
    exit 1
  fi
done

# Decide to run step
function checkpoint () {
  message=$1
  runAllStep=$2

  if [ "$runAllStep" == "0" ]
  then
    read -r -p "$message"
  fi

  case "$REPLY" in
      y|Y|yes|YES|"" ) echo "yes";;
      n|N|no|No ) echo "no";;
      * ) echo "Invalid";;
  esac
}

runAllStep=0

#try
(
  set -e

  msg="Excute all step ? [Y/n] "
  if [ "$(checkpoint "$msg" "$runAllStep")" == "yes" ]
  then
      runAllStep=1
  fi

  msg="Run step 1 ? [Y/n] "
  if [ "$(checkpoint "$msg" "$runAllStep")" == "yes" ]
  then
      echo "Print VARIABLE_1: $VARIABLE_1"
  fi

  msg="Run step 2 ? [Y/n] "
  if [ "$(checkpoint "$msg" "$runAllStep")" == "yes" ]
  then
        echo "Print VARIABLE_2: $VARIABLE_2"
  fi

  msg="Run step 3 ? [Y/n] "
  if [ "$(checkpoint "$msg" "$runAllStep")" == "yes" ]
  then
        echo "Print VARIABLE_3: $VARIABLE_3"
  fi
)

#Catch exception
errorCode=$?
if [ $errorCode -ne 0 ]; then
  exit $errorCode
fi
