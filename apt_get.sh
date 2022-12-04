set -u
set -e

function apt_get_run() {
  infom "Running \"apt-get $@\"..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y "$@"
}
export -f apt_get_run
