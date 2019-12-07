set -u
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;93m'
CYAN='\033[0;36m'
NC='\033[0m'

function outerr() {
  local first=1
  for value in "$@"; do
    if [ -n "$first" ]; then
      first=''
    else
      >&2 printf -- ' '
    fi
    >&2 printf -- "$value"
  done
}

# Outputs a error message.
function error() {
  outerr "${RED}Error: ${NC}"
  outerr "$@"
  outerr "\n"
}

function infom() {
  outerr "${YELLOW}$@${NC}\n"
}

function infov() {
  outerr "${CYAN}$1: ${NC}"
  shift
  outerr "$@"
  outerr "\n"
}

# Outputs a error message and exit with error code.
function fatal_error() {
  set -u
  set -e

  error "$@"
  exit 1
}

function info_ok() {
  printf "${GREEN}$@${NC}\n"
}
