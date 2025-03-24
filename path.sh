function file_mime_type() {
  file --mime-type --brief "$@"
}

function path_expand() {
  PATH_ARG="$1"
  if [ $# -ge 2 ]; then
    BASE_ARG="$2"
  else
    BASE_ARG="$PWD"
  fi

  if [[ "$PATH_ARG" == '/'* ]]; then
    printf -- "%s\n" "$PATH_ARG"
  else
    printf -- "%s/%s\n" "$BASE_ARG" "$PATH_ARG"
  fi
}
export -f path_expand

function symlink_assert() {
  infom 'Asserting symlink...'
  local SOURCE="$1"
  local TARGET="$2"
  infov_compact 'SOURCE' 'TARGET'
  if [ -L "$TARGET" ]; then
    if [ "$(realpath "$TARGET")" == "$SOURCE" ]; then
      infom 'Symlink already exist with the correct source.'
      return 0
    else
      infom 'Target does not point to the source. Removing target...'
      rm "$TARGET"
    fi
  elif [ -e "$TARGET" ]; then
    error 'Target already exists, is not a symlink and because of this cannot be removed.'
    return 1
  else
    infom "Target does not exist."
  fi
  infom 'Creating symlink...'
  mkdir -p "$(dirname "$TARGET")"
  ln -s "$SOURCE" "$TARGET"
}
export -f symlink_assert
