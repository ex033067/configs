#  vim: filetype=sh

unset -f __completion_for_p
function __completion_for_p () {
    prevword=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(cd ${PROJECT_ROOT};compgen -d -- $prevword) )
}

complete -F __completion_for_p p
