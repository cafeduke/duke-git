# -------------------------------------------------------------------------------------------------
# Function
# -------------------------------------------------------------------------------------------------

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
  mesg="${mesg} [y]/n ?"

  echo "${mesg}"
  read yorn

  if [[ ! -z "${yorn}" && "${yorn}" != "y" ]]
  then
    exit 0
  fi
}

##
# 1. Checks for any merge conflicts
# 2. Lists the conflicts
# 3. Prompts user to open 'meld' (A UI tool to resolve merge conflicts) to resolve merge conflits.
#   3.1. If meld is not configured in ~/.gitconfig, the file is updated. 
#   3.2. If meld is not installed and user is prompted to install meld -- The function exits with error.
# 4. Open meld to resolve merge conflits
#
# The above steps are repeated until all merge conflicts are resolved.
# 
# @return : Return 0 if there were no merge conflicts to begin with, 1 otherwise.
##
function checkMergeConflit {  
  local hadConflit=0
  mergeConflit=$(git diff --name-only --diff-filter=U)
  while [[ ! -z "${mergeConflit}" ]]
  do

    hadConflit=1

    highlight "CAUTION: *** Merge conflicts found ***" "List of conflicts"
    git diff --name-only --diff-filter=U

    echo ""
    checkAndProceed "Open conflicts using meld tool"
    checkMeld

    git mergetool
    mergeConflit=$(git diff --name-only --diff-filter=U)
  done
  return ${hadConflit}
}
##
# Display as heading
#
# Arguments:
#   mesg - Messages to be displayed
##
function heading {
  echo ""
  echo "---------------------------------------------------------------------------------------------------"
  for mesg in "$@"
  do
    echo "${mesg}"
  done  
  echo "---------------------------------------------------------------------------------------------------"
}

##
# Display as alert heading
#
# Arguments:
#   mesg - Messages to be displayed
##
function highlight {
  echo ""
  echo "###################################################################################################"
  for mesg in "$@"
  do
    echo "${mesg}"
  done  
  echo "###################################################################################################"
}

##
# Print the error message, usage and exit. A callback to function by name 'usage' is made if it exists.
# 
# Arguments:
#   mesg - Error message
##
function dieUsage {
  local mesg=${1}
  echo "Error: ${mesg}"
  if [[ `function_exists "usage"` -eq 0 ]]
  then
    usage
  fi
  exit 1
}

##
# Print error message and exit
##
function dieOnError {
  local status=$?
  local mesg=${1}
  if [[ ${status} -ne 0 ]]
  then
    echo "####################################################################################################"
    echo "Error: ${mesg} ExitStatus=${status}"
    echo "####################################################################################################"
    exit ${status}
  fi
}

##
# Check if a function by name <$1> exists. Return 0 if function exists.
## 
function_exists() {
  local fname=${1}
  declare -f -F ${fname} >& /dev/null
  return $?
}

##
# Check for meld installation
##
function checkMeld {

  # Check if meld is configured in ~/gitconfig
  checkMeld=$(grep -q meld ${HOME}/.gitconfig; echo $?)
  if [[ ${checkMeld} -eq 1 ]]
  then
    echo "Configuring meld"
    git config --global diff.tool meld
    git config --global difftool.prompt false
  fi  

  which meld &> /dev/null
  dieOnError "Install meld (sudo apt install meld). Required to resolve conflit."
  echo "Meld configured and found in path"
}
