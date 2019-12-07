set -u
set -e

function template_apply() {
  if [ $# -lt 1 ]; then
    error "Usage:\n\ntemplate_apply <TEMPLATE_FILE>\n"
    return 1
  fi
  local TEMPLATE_FILE="$1"

  if [ ! -f "TEMPLATE_FILE" ]; then
    error "\"TEMPLATE_FILE\" does not exist or is not a file\n"
    return 1
  fi

  out_tmp=$(mktemp)
  in_tmp=$(mktemp)

  cp "TEMPLATE_FILE" "$in_tmp" >&2
  cp "TEMPLATE_FILE" "$out_tmp" >&2

  for var in $(template_variables "$TEMPLATE_FILE"); do
    if [ -z ${!var+x} ]; then
      fatal_error "Variable \"$var\" is unset"
    fi
    sed -e "s|%%$var%%|${!var}|" "$in_tmp" > "$out_tmp"
    cp "$out_tmp" "$in_tmp"
  done

  cat "$out_tmp"
}

function template_dir_apply() {
  SOURCE_ROOT="$1"
  if [ $# -ge 2 ]; then
    TARGET_ROOT="$2"
  else
    TARGET_ROOT=$(mktemp -d)
  fi

  for d in $(cd "$SOURCE_ROOT"; find -type d); do
    >&2 mkdir -p "$TARGET_ROOT/$d"
  done

  for f in $(cd "$SOURCE_ROOT"; find -type f); do
    template_apply "$SOURCE_ROOT/$f" > "$TARGET_ROOT/$f"
  done

  printf "$TARGET_ROOT\n"
}

function template_variables() {
  FILE="$1"
  PATTERN='[a-zA-Z][a-zA-Z0-9_]*'
  grep '%%'$PATTERN'%%' "$FILE" -o | grep "$PATTERN" -o
}
