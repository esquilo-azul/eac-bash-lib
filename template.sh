set -u
set -e

function template_variables() {
  FILE="$1"
  PATTERN='[a-zA-Z][a-zA-Z0-9_]*'
  grep '%%'$PATTERN'%%' "$FILE" -o | grep "$PATTERN" -o
}
