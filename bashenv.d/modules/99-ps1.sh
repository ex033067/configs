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

_prompt_command () {
	LAST_EXIT_CODE=$?
	if [[ ${LAST_EXIT_CODE} -eq 0 ]]; then
		local ps1_status="\[\e[0;32m\]\$" # green
	else
		local ps1_status="\[\e[0;31m\]\$ ${LAST_EXIT_CODE}" # red
	fi

	if [[ "${PWD}" = "${PS1_PREVIOUS_PWD}" ]]; then
		# Shortcut to improve performance because user didn't cd into other dir.
		local project="${PS1_PREVIOUS_PROJECT}"
	else
		# Remove $PROJECT_ROOT from $PWD
		local project="${PWD#${PROJECT_ROOT}/}"
		if [[ "${PWD}" = "${project}" ]]; then
			# Not inside any project. Abbreviate $HOME with "~".
			# Ex.: Transform "/Users/viniciusban/Library" into "~/Library".
			project="${PWD/${HOME}/~}"
		else
			# Inside a project. Abbreviate intermediary dirs with "...".
			# Ex.: Tranform "myproj/usr/somedir/otherdir" into "myproj/...otherdir".
			project="${project//\/*\///...}"
		fi
	fi
	PS1="${ps1_status} @\h:${project}${VIRTUAL_ENV:+()}\$ \[\e[0m\]"

	PS1_PREVIOUS_PWD="${PWD}"
	PS1_PREVIOUS_PROJECT="${project}"
}

PROMPT_COMMAND=_prompt_command
