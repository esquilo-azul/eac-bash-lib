set -u
set -e

function deb_installed() {
  for PKG in $@; do
    RESULT=`dpkg-query -W '-f=${Status}' "$PKG"`
    if [ "$RESULT" != 'install ok installed' ] ; then
      return 1
    fi
  done
}
