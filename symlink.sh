function symlink_assert() {
  infom 'Asserting symlink...'
  local TARGET_PATH="$1"
  local LINK_PATH="$2"
  infov_compact 'TARGET_PATH' 'LINK_PATH'
  if [ -L "$LINK_PATH" ]; then
    if [ "$(realpath "$LINK_PATH")" == "$TARGET_PATH" ]; then
      infom 'Symlink already exist with the right target.'
      return 0
    else
      infom 'Symlink does not point to the target. Removing target...'
      rm "$LINK_PATH"
    fi
  elif [ -e "$LINK_PATH" ]; then
    error 'A object in the symlink path already exists, is not a symlink and because of this cannot be removed.'
    return 1
  else
    infom "Symlink does not exist."
  fi
  infom 'Creating symlink...'
  mkdir -p "$(dirname "$LINK_PATH")"
  ln -s "$TARGET_PATH" "$LINK_PATH"
}
export -f symlink_assert
