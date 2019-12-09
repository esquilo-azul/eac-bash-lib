function ruby_gem_installed() {
  for GEM in "$@"; do
    if gem list --local | grep -io '^[0-9a-z\-]\+' | grep -i "^$GEM\$" &> /dev/null; then
      return 1
    fi
  done
}
