#  vim: filetype=sh

unset -f __ps1_git
function __ps1_git () {
    # Show git branch and indicator about status:
    #   - "!" means there are unstaged changes
    #   - "+" means some or all changes are staged

    local BRANCHES=$(git branch 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        # Not a git repo
        return
    fi

    local BRANCH=$(echo "$BRANCHES" | grep '^*' | cut -d' ' -f2- | tr -d '()')
    if [ -z "$BRANCH" ]; then
        # New repo still without any commits
        return
    fi

    # Items not committed
    local PENDING=$(git status --porcelain 2>/dev/null)

    # No pending commit
    [ -z "$PENDING" ] && echo "$BRANCH" && return

    # Staged and/or unstaged files
    local staged=$(echo "$PENDING" | grep '^[ACDMR]' >/dev/null && echo '+')
    local unstaged=$(echo "$PENDING" | grep '^[ ?][ACDMR?]' >/dev/null && echo '!')
    echo "${staged}${unstaged}${BRANCH}" && return
}

# Set PS1
#
# Colorcodes from
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# section "256 (8-bit) Colors"
#
# tput colors from
# http://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes#269195

PS1='$(RC=$?;GREEN="\[\033[0;32m\]";RED="\[\033[0;31m\]";[ $RC -eq 0 ] && echo "${GREEN}$ " || echo "${RED}$ ${RC} ")${debian_chroot:+($debian_chroot)}@\h:${VIRTUAL_ENV:+(}\W$(BRANCH=$(__ps1_git);echo "${BRANCH:+ $BRANCH}")${VIRTUAL_ENV:+)}\$ \[\033[00m\]'
