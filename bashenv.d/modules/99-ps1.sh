#  vim: filetype=sh

# Set PS1
#
# Colorcodes from
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# section "256 (8-bit) Colors"
#
# tput colors from
# http://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes#269195

unset -f __ps1_git 
__ps1_git () {

	# Show git branch and indicators about status:
	#   - "+" means there are staged changes
	#   - "!" means there are unstaged changes

	#
	# The main concern here is performance. So, I return as soon as possible,
	# use the result and cache set on last execution, avoid to call external
	# processes like grep, sed, etc. and abuse of bash expressions and logic.
	#
	# Renew cache (a.k.a call git) after 1 second, instead of in every <enter>
	# to avoid prompt flicking.
	#
	# Note: when not inside a git repository, "git status" will fail and show
	# empty result. On next <enter>, it would try to "git status" again because
	# $PS1_GIT_STATUS_CACHE is empty. That's what "echo fail" addresses. ;-)

	if [[ -z "${PS1_GIT_STATUS_CACHE}" ]]; then
		PS1_GIT_STATUS_CACHE=$(git status -b --porcelain=2 2>/dev/null || (echo 'fail'; false))
		PS1_GIT_STATUS_EXIT_CODE=$?
	elif [[ $(( SECONDS - PS1_SECONDS )) -gt 1 ]]; then
		PS1_GIT_STATUS_CACHE=$(git status -b --porcelain=2 2>/dev/null || (echo 'fail'; false))
		PS1_GIT_STATUS_EXIT_CODE=$?
	else
		PS1_SECONDS=$SECONDS
		return
	fi
	PS1_SECONDS=$SECONDS

    if [[ ${PS1_GIT_STATUS_EXIT_CODE} -ne 0 ]]; then
        # Not a git repo
		PS1_GIT=
        return
    fi

	local branch staged_indicator unstaged_indicator
	local rectype field1 field2 other_fields
	local branch_header="#"
	local untracked_item="?"
	local changed_item="1"
	local renamed_item="2"
	local unmerged_item="u"
	while read rectype field1 field2 other_fields; do
		if [[ -n "${staged_indicator}" && -n "${unstaged_indicator}" ]]; then
			# Indicator are already set. There's nothing more to look for.
			break
		fi
		if [[ -z "${branch}" && "${rectype}" = "${branch_header}" && "${field1}" = "branch.head" ]]; then
			local branch="${field2}"
			continue
		fi

		if [[ "${untracked_item}${unmerged_item}" =~ "${rectype}" ]]; then
			local unstaged_indicator="!"
			continue
		fi

		if [[ "${changed_item}${renamed_item}" =~ "${rectype}" ]]; then
			if [[ "${field1:0:1}" != "." ]]; then
				local staged_indicator="+"
			fi
			if [[ "${field1:1:1}" != "." ]]; then
				local unstaged_indicator="!"
			fi
			continue
		fi
	done <<< "${PS1_GIT_STATUS_CACHE}"

	PS1_GIT=":${staged_indicator}${unstaged_indicator}${branch}"
}

unset -f __prompt_command
__prompt_command () {
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
			project="${PWD/${HOME}/\~}"
		else
			# Inside a project. Abbreviate intermediary dirs with "...".
			# Ex.: Tranform "myproj/usr/somedir/otherdir" into "myproj/...otherdir".
			project="${project//\/*\///...}"
		fi
	fi

	__ps1_git
	PS1="${ps1_status} @\h:${project}${PS1_GIT}${VIRTUAL_ENV:+()}\$ \[\e[0m\]"

	PS1_PREVIOUS_PWD="${PWD}"
	PS1_PREVIOUS_PROJECT="${project}"
}

PROMPT_COMMAND=__prompt_command
