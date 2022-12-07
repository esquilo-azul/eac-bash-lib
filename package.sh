function package_assert_installed() {
  PLUGIN="$1"
  shift
  INSTALL=()
  for PKG in $@; do
    if ! package_installed "$PLUGIN" "$@"; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    package_install_multiple "$PLUGIN" "${INSTALL[@]}"
  fi
}
export -f package_assert_installed

function package_install_multiple() {
  PLUGIN="$1"
  shift
  "${PLUGIN}_install_multiple" "$@"
}
export -f package_install_multiple

function package_installed() {
  PLUGIN="$1"
  shift
  for PKG in $@; do
    if ! package_installed_single "$PLUGIN" "$PKG"; then
      return 1
    fi
  done
}
export -f package_installed

function package_installed_single() {
  "${1}_installed_single" "$2"
}
export -f package_installed
