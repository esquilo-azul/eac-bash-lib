set -u
set -e

# Deprecated: use apt_assert_installed() instead.
function deb_assert_installed() {
  apt_assert_installed "$@"
}
export -f deb_assert_installed

# Deprecated: use dpkg_installed() instead.
function deb_installed() {
  dpkg_installed "$@"
}
export -f deb_installed
