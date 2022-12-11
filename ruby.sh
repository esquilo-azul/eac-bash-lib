source "$EACBASHLIB_ROOT/ruby/gem.sh"
source "$EACBASHLIB_ROOT/ruby/rvm.sh"

function ruby_install_multiple() {
  gem install -V "$@"
}
export -f ruby_install_multiple
