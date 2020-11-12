function cli_file_path_or_stdin() {
  local SOURCE_PATH="$1"
  if [ "$SOURCE_PATH" = '-' ]; then
    local SOURCE_PATH='/dev/stdin'
  elif [ ! -f "$SOURCE_PATH" ]; then
    fatal_error "File \"$SOURCE_PATH\" does not exist or is not a file (${FUNCNAME[@]})\n"
    return 1
  fi
  printf "%s\n" "$SOURCE_PATH"
}
