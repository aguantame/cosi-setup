#!/bin/bash

# This bash script is part of the MEGAlib & COSItools setup procedure.
# As such it is dual licenced under Apache 2.0 for COSItools and LGPL 3.0 for MEGAlib
#
# Development lead: Andreas Zoglauer
#
# Description:
# Source all cfitsio-related environment variables



# Make this script work with zsh
if [ -n "$ZSH_VERSION" ]; then emulate -L ksh; fi


# Print some help 
confhelp() {
  echo ""
  echo "This script sources all cfitsio-related environment variables"
  echo " "
  echo "Usage: ./source-cfitsio.sh --path=[full path to the cfitsio installation]";
  echo " "
}


# Parse the command line
CMD=( "$@" )

__TMP_PATH=""
__TMP_HERE=$(pwd)

for C in "${CMD[@]}"; do
  if [[ ${C} == *-p*=* ]]; then
    __TMP_PATH=`echo ${C} | awk -F"=" '{ print $2 }'`
  elif [[ ${C} == *-h ]] || [[ ${C} == *-hel* ]]; then
    echo ""
    confhelp
    exit 0
  fi
done


# Perform sanity checks

# We require an absolute path
if [[ ${__TMP_PATH} != /* ]]; then
  echo ""
  echo "ERROR: The cfitsio path must be an absolute path: ${__TMP_PATH}"
  echo ""
  return
fi

# The directory must exist
if [[ ! -d ${__TMP_PATH} ]]; then
  echo ""
  echo "ERROR: cfitsio directory not found: ${__TMP_PATH}"
  echo ""
  return
fi


# Source the cfitsio environment 
export CFITSIO=${__TMP_PATH}
export LHEASOFT=${__TMP_PATH} # For easy compatibility with MEGAlib
export LD_LIBRARY_PATH=${CFITSIO}/lib:${LD_LIBRARY_PATH}


return
