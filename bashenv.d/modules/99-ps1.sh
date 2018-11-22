#  vim: filetype=sh

unset -f __ps1_git
function __ps1_git () {
    # Show git branch and indicator about status:
    #   - "?" means no modified objects were staged
    #   - "+" means some (or all) modified objects were staged

    local BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -z "$BRANCH" ];then
        local BRANCH=$(git branch >/dev/null 2>&1 && git branch 2>/dev/null | grep '^*' | cut -d' ' -f2- | tr -d '()')
        # Note about 2 "git branch"es above:
        # When user is in a directory that isn't a git repo, "git branch" will
        # return error 128 and we don't need to parse its output. Thus,
        # performing an "and" (&&) with next command suffices to exist asap.
        if [ -z "$BRANCH" ]; then
            return
        fi
    fi

    # Items not committed
    local ITEMS=$(git status --porcelain 2>/dev/null)

    # No pending commit
    [ -z "$ITEMS" ] && echo "$BRANCH" && return

    # Staged objects (some or all of them).
    echo "$ITEMS" | grep '^[RMDA]' >/dev/null && echo "+${BRANCH}" && return

    # Modified, but none staged yet.
    echo "!${BRANCH}" && return
}

# Set PS1
#
# Colorcodes from
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# section "256 (8-bit) Colors"
#
# tput colors from
# http://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes#269195

PS1='$(RC=$?;GREEN="\[\033[0;32m\]";RED="\[\033[0;31m\]";[ $RC -eq 0 ] && echo "${GREEN}> " || echo "${RED}> ${RC} ")${debian_chroot:+($debian_chroot)}@\h:${VIRTUAL_ENV:+(}\W$(BRANCH=$(__ps1_git);echo "${BRANCH:+ $BRANCH}")${VIRTUAL_ENV:+)}\$ \[\033[00m\]'
