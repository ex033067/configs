#  vim: filetype=sh

unset -f p
function p () {
    local dir=${PROJECT_ROOT}/$1
    if [ -d "$dir" ]; then
        cd ${PROJECT_ROOT}/$1
        return
    fi

    local find="find ${PROJECT_ROOT} -maxdepth 1 -name '$1*' -type d"
    local possibilities=$(eval $find | wc -l)
    if [ "$possibilities" = '0' ]; then
        echo 'No project found'
        return 1
    elif [ "$possibilities" = '1' ]; then
        echo "entering"
        cd "$(eval $find)"
        return
    else
        echo 'More then one project found'
        echo "$(eval $find)"
        return 1
    fi

}
