#  vim: filetype=sh

unset -f p
function p () {
    cd ${PROJECT_ROOT}/$1
}
