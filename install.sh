#!/bin/bash -e

# -------------------------------------------------------------------------------------------------
# Functions
# -------------------------------------------------------------------------------------------------
BASEDIR=$(dirname $(readlink -f ${0}))

function usage {
  echo "Install duke-git scripts"
  echo "Usage: ${0} [<install location> (Default=$HOME/bin/duke-git)]"
  exit 0
}


# -------------------------------------------------------------------------------------------------
# Parse Arg
# -------------------------------------------------------------------------------------------------
if [[ ${#} -eq 1 && ("${1}" == "-h" || "${1}" == "--help") ]]
then
  usage
fi

installDir="${HOME}/bin/duke-git"
if [[ ${#} -eq 1 ]]
then
  installDir=${1}
fi

# -------------------------------------------------------------------------------------------------
# Main
# -------------------------------------------------------------------------------------------------
mkdir -p ${installDir}
cp -rP ${BASEDIR}/bin/* ${installDir}
echo "Installed in ${installDir}"
echo "Please add ${installDir} to PATH environment variable."
