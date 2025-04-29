function symlink_assert() {
  infom 'Asserting symlink...'
  local LINK_PATH="$1"
  local TARGET_PATH="$2"
  if symlink_exist "$LINK_PATH"; then
    if [ "$(sudo_run realpath "$LINKPATH")" == "$TARGET" ]; then
      infom 'Symlink already exist with the right target.'
      return 0
    else
      infom 'Symlink does not point to the target. Removing target...'
      sudo_run rm "$LINK_PATH"
    fi
  elif [ -e "$LINK_PATH" ]; then
    error 'A object in the symlink path already exists, is not a symlink and because of this cannot be removed.'
    return 1
  else
    infom "Symlink does not exist."
  fi
  infom 'Creating symlink...'
  sudo_run mkdir -p "$(dirname "$LINK_PATH")"
  sudo_run ln -s "$TARGET_PATH" "$LINK_PATH"
}
export -f symlink_assert

function symlink_exist() {
  [[ -L "$1" ]]
}
export -f symlink_exist
