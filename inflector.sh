set -u
set -e

function parameterize() {
  if [ $# -ge 1 ]; then
    printf -- "$@" | parameterize
  else
    RESULT="$(sed 's/[^a-z0-9A-Z]\+/-/g' <&0 | sed 's/^-\+//g' | sed 's/-\+$//g')"
    printf -- "${RESULT,,}\n"
  fi
}
