#  vim: filetype=sh

unset -f mkcd
function mkcd () {
    # Make a dir and cd into it.
    mkdir -p $1 && cd $1
}
