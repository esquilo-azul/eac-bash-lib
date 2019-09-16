set -u
set -e

function template_apply() {
  if [ ! -f "$1" ]; then
    >&2 printf "\"$1\" does not exist or is not a file\n"
    return 1
  fi

  out_tmp=$(mktemp)
  in_tmp=$(mktemp)

  cp "$1" "$in_tmp" >&2
  cp "$1" "$out_tmp" >&2

  for var in $(template_variables "$1"); do
    if [ -z ${!var+x} ]; then
      >&2 echo "Variable \"$var\" is unset"
      return 2
    fi
    sed -e "s|%%$var%%|${!var}|" "$in_tmp" > "$out_tmp"
    cp "$out_tmp" "$in_tmp"
  done

  cat "$out_tmp"
}

function template_variables() {
  FILE="$1"
  PATTERN='[a-zA-Z][a-zA-Z0-9_]*'
  grep '%%'$PATTERN'%%' "$FILE" -o | grep "$PATTERN" -o
}
