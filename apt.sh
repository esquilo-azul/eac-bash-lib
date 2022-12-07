set -u
set -e

function apt_get_run() {
  infom "Running \"apt-get $@\"..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y "$@"
}
export -f apt_get_run

function apt_assert_installed() {
  INSTALL=()
  for PKG in $@; do
    if ! dpkg_installed "$PKG" ; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    apt_get_run install "${INSTALL[@]}"
  fi
}
export -f apt_assert_installed

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
