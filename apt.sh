set -u
set -e

function apt_get_run() {
  infom "Running \"apt-get $@\"..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y "$@"
}
export -f apt_get_run

function apt_install_multiple() {
  apt_get_run update
  apt_get_run install "$@"
}
export -f apt_install_multiple

function apt_installed_single() {
  dpkg_installed "$@"
}
export -f apt_installed_single

function apt_assert_uninstalled() {
  INSTALL=()
  for PKG in $@; do
    if deb_installed "$PKG" ; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    apt_get_run purge "${INSTALL[@]}"
  fi
}
export -f apt_assert_uninstalled

function apt_update() {
  apt_get_run update
}
export -f apt_update
