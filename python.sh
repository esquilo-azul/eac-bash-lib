export DEFAULT_PIP_COMMAND='pip'

function python_assert_installed() {
  INSTALL=()
  for PKG in $@; do
    if ! python_installed "$PKG" ; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    infom "Será necessário instalar os seguintes pacotes Python: $INSTALL"
    sudo "$(python_pip_command)" install "${INSTALL[@]}"
  fi
}
export -f python_assert_installed

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
