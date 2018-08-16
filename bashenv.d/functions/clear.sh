#  vim: filetype=sh

unset -f clear
function clear () {
    [ -z "$1" ] && $(which clear) || seq 1 $1 | tr '[:digit:]' ' '
}
