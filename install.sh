#!/bin/bash -e

# -------------------------------------------------------------------------------------------------
# Function
# -------------------------------------------------------------------------------------------------

BASEDIR=$(dirname $(readlink -f ${0}))
BASENAME=$(basename ${0})

function log {
  local mesg=${1}
  echo "[$(date)] ${mesg}"
}

function printTaskBegin {
  local mesg=${1}
  echo -ne "${mesg} ...\r"
}

function printTaskEnd {
  local mesg=${1}
  echo "${mesg} ... Done"
}

##
# Prompt user to continue. 'y' by default.
# Exit if user types any non-empty string other than 'y'
##
function checkAndProceed {
  local mesg=${1}
  if [[ -z "${mesg}" ]]
  then
    mesg="Continue"
  fi
  mesg="${mesg}? [y]/n :"

  echo -n "${mesg}"
  read yorn

  if [[ ! -z "${yorn}" && "${yorn}" != "y" ]]
  then
    exit 0
  fi
}

function usage {
  echo "Usage: ${BASENAME} [<install-root>]"
  echo "Default <install-root> : ${HOME}/bin"
  echo "Files shall be installed under directory '<install-root>/duke-git'"
}

##
# Display as hr
##
function hr {
  echo "---------------------------------------------------------------------------------------------------"
}

# -------------------------------------------------------------------------------------------------
# ParseArg
# -------------------------------------------------------------------------------------------------
if [[ ${#} -eq 1 && ("${1}" == "-h" || "${1}" == "--help") ]]
then
  usage
  exit 0
fi

INSTALL_ROOT="${HOME}"
if [[ ${#} -eq 1 ]]
then
  INSTALL_ROOT=$(readlink -f ${1})
fi
INSTALL_HOME=${INSTALL_ROOT}/duke-git

# -------------------------------------------------------------------------------------------------
# Main
# -------------------------------------------------------------------------------------------------

# Remove ${INSTALL_HOME} after checking with user
[[ -e ${INSTALL_HOME} ]] && checkAndProceed "${INSTALL_HOME} exists, overwrite contents"
rm -rf ${INSTALL_HOME} /tmp/duke-master.zip

# Create root dir if it does not exist
mkdir -p ${INSTALL_ROOT}

printTaskBegin "Downloading files"
wget -q https://github.com/cafeduke/duke-git/archive/refs/heads/master.zip -O /tmp/duke-master.zip
printTaskEnd   "Downloading files"

printTaskBegin "Install files in ${INSTALL_HOME}"
unzip -q /tmp/duke-master.zip -d ${INSTALL_ROOT}
mv ${INSTALL_ROOT}/duke-git-master ${INSTALL_HOME}
rm /tmp/duke-master.zip
printTaskEnd   "Install files in ${INSTALL_HOME}"

hr
echo "Install completed successfully!"
echo "Please add ${INSTALL_HOME}/bin to PATH"
