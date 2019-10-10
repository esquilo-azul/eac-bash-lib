set -u
set -e

function var_blank_r() {
  if var_present_r "$1"; then
    return 1
  else
    return 0
  fi
}

function var_present_r() {
  NAME="$1"
  if [ -v "${NAME}" ]; then
    bool_r "${!NAME}"
  else
    return 1
  fi
}
