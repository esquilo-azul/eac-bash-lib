set -u
set -e

function var_present_r() {
  NAME="$1"
  if [ -v "${NAME}" ]; then
    bool_r "${!NAME}"
  else
    return 1
  fi
}
