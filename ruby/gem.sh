# Deprecated: use "package_assert ruby" instead.
function ruby_gem_install() {
  for GEM in "$@"; do
    if ! ruby_gem_installed "$GEM"; then
      ruby_install_multiple "$GEM"
    fi
  done
}

function ruby_gem_installed() {
  for GEM in "$@"; do
    if ! gem list --local | grep -io '^[0-9a-z\-]\+' | grep -i "^$GEM\$" &> /dev/null; then
      return 1
    fi
  done
}
