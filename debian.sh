set -u
set -e

# Deprecated: use apt_assert_installed() instead.
function deb_assert_installed() {
  apt_assert_installed "$@"
}
export -f deb_assert_installed

function deb_installed() {
  for PKG in $@; do
    RESULT=`dpkg-query -W '-f=${Status}' "$PKG"`
    if [ "$RESULT" != 'install ok installed' ] ; then
      return 1
    fi
  done
}
export -f deb_installed
