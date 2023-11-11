export DEFAULT_PIP_COMMAND='pip'

function python_install_multiple() {
  "$(python_pip_command)" install "$@"
}
export -f python_install_multiple

# Deprecated: use "package_installed python" instead.
function python_installed() {
  for PKG in $@; do
    if ! python_installed_single "$PKG"; then
      return 1
    fi
  done
}
export -f python_installed

function python_installed_single() {
  PACKAGE="$1"
  RESULT="$("$(python_pip_command)" list | cut -d ' ' -f1 | grep "$PACKAGE")"
  if [ "$RESULT" != "$PACKAGE" ] ; then
    return 1
  fi
}
export -f python_installed_single

function python_pip_command() {
  if var_present_r 'PIP_COMMAND'; then
    outout "${PIP_COMMAND}\n"
  else
    outout "${DEFAULT_PIP_COMMAND}\n"
  fi
}
