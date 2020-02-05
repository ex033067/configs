#  vim: filetype=sh


__aliases () {
	alias ..='cd ..'
	alias .2='cd ../..'
	alias .3='cd ../../..'

	alias l='ls -lhgo'
	alias ll='ls -lh'
	[[ "${OSNAME}" = "Darwin" ]] && alias ls='ls -Gp'
	[[ "${OSNAME}" = "Linux" ]] && alias ls='ls -p --group-directories-first --color=auto'

	alias ack='ack --sort-files --color-filename="bold blue" --color-lineno="blue" --color-match="bold white on_blue" --ignore-dir=is:.venv --ignore-dir=is:.vagrant --ignore-file=ext:sqlite3'
	alias grep='grep --color=auto'

	alias django='python manage.py'
	alias now='date -u +%y%m%d%H%M'
	alias p='_partialcd'
	alias todo='cd ~/Dropbox/todo && $EDITOR todo.todo'

	# one-letters
	alias e='$EDITOR'
	alias j='jupyter notebook --no-browser --ip=localhost.test --NotebookApp.allow_remote_access=True'
	alias r='runserver'
}


__shell_options () {
	set -o vi
}


__variables () {
	if [[ -n "$WSL_DISTRO_NAME" ]]; then
		export DISPLAY=:0
	fi

	if [[ -r /home/linuxbrew/.linuxbrew/bin/brew ]]; then
		eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	fi

	export PROJECT_ROOT=~/projects
	[[ -z "$TMPDIR" ]] && export TMPDIR=/tmp

	export HISTCONTROL=ignoreboth
	export HISTTIMEFORMAT="%F %T "

	export EDITOR='nvim'
	export VISUAL=$EDITOR

	# Default "UTF-8" in MacOS makes python crash.
	[[ "${OSNAME}" = "Darwin" ]] && export LC_CTYPE="en_US.UTF-8"

	# pyenv
	if [[ -d ~/.local/bin/pyenv ]]; then
	    export PYENV_ROOT=~/.local/bin/pyenv
	else
	    export PYENV_ROOT=~/.pyenv
	fi
	export PATH="$PYENV_ROOT/bin:$PATH"

	if which pyenv > /dev/null
	then
	    eval "$(pyenv init -)"
	    pyenv global 3.7.6 docker_compose tools jupyter 2.7.17
	fi

	# vagrant
	[[ -d /Volumes/hd2/${USER}/.vagrant.d ]] && export VAGRANT_HOME=/Volumes/hd2/${USER}/.vagrant.d
	export VAGRANT_BOX_UPDATE_CHECK_DISABLE=1

	# asdf-vm
	if [[ -d ~/.asdf ]]; then
		source $HOME/.asdf/asdf.sh
		source $HOME/.asdf/completions/asdf.bash
	fi

	# final PATH
	export PATH="$HOME/.local/bin/binscripts:$PATH"

	# partialcd
	if [[ -r ~/.local/bin/partialcd ]]; then
		export PARTIALCD_ROOT=~/projects
		source ~/.local/bin/partialcd
	fi

	# ssh-agent
	# if [[ "${OSNAME}" = "Linux" ]]; then
	#     if pgrep ssh-agent >/dev/null 2>&1 ; then
	#         export SSH_AGENT_PID=$(pgrep ssh-agent | head -n 1)
	#         export SSH_AUTH_SOCK=$(find /tmp/ssh* -name 'agent.'"$(( SSH_AGENT_PID - 1 ))")
	#     else
	#         eval $(ssh-agent -t 3600) # cache key for 3600 secs (1 hour).
	#     fi
	# fi
}


__define_functions () {
	unset -f __ps1_git 
	__ps1_git () {
		# Show git branch and indicators about status:
		#   - "+" means there are staged changes
		#   - "!" means there are unstaged changes

		# The main concern here is performance. So, I return as soon as
		# possible, cache last execution, avoid calling external processes like
		# grep, sed, etc. and abuse of bash expressions and logic.

		PS1_GIT_STATUS_OUTPUT=$(git status -b --porcelain=2 2>/dev/null)
		PS1_GIT_STATUS_EXIT_CODE=$?

		if [[ ${PS1_GIT_STATUS_EXIT_CODE} -ne 0 ]]; then
			# Not a git repo
			PS1_GIT=
			return
		fi

		if [[ "${PS1_GIT_STATUS_OUTPUT}" = "${PREVIOUS_PS1_GIT_STATUS_OUTPUT}" ]]; then
			# Nothing changed since previous prompt. Reuse current $PS1_GIT.
			return
		fi

		PREVIOUS_PS1_GIT_STATUS_OUTPUT="${PS1_GIT_STATUS_OUTPUT}"

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
		done <<< "${PS1_GIT_STATUS_OUTPUT}"

		PS1_GIT="${staged_indicator}${unstaged_indicator}${branch}"
	}

	unset -f __prompt_command
	__prompt_command () {
		local last_exit_code=$?  # it must be the first statement!

		local ps1_color_reset="\[\e[0m\]"
		if [[ -z "$PS1_OK_COLOR" ]]; then
			if [[ -r ~/.ps1colorrc ]]; then
				source ~/.ps1colorrc  # define $PS1_OK_COLOR and $PS1_ERROR_COLOR
			fi
		fi
		if [[ ${last_exit_code} -eq 0 ]]; then
			local ps1_status=
		else
			local ps1_status="${last_exit_code}"
		fi

		__ps1_git

		if [[ -n "${VIRTUAL_ENV}" ]]; then
			if [[ "${VIRTUAL_ENV}" = "${PREVIOUS_VIRTUAL_ENV}" ]]; then
				local ps1_virtual_env="${PREVIOUS_PS1_VIRTUAL_ENV}"
				local ps1_python_version="${PREVIOUS_PS1_PYTHON_VERSION}"
			else
				local ps1_virtual_env=$(basename ${VIRTUAL_ENV})
				if [[ "${ps1_virtual_env}" = ".venv" ]]; then
					local ps1_virtual_env=$(basename $(dirname ${VIRTUAL_ENV}))
				fi
				local ps1_python_version=$(python --version 2>&1 | while IFS=' ' read _dummy version; do echo $version; break; done)
				ps1_virtual_env="${ps1_virtual_env} ${ps1_python_version}"
			fi
		else
			local ps1_virtual_env=
		fi
		PREVIOUS_PS1_VIRTUAL_ENV="${ps1_virtual_env}"
		PREVIOUS_PS1_PYTHON_VERSION="${ps1_python_version}"
		PREVIOUS_VIRTUAL_ENV="${VIRTUAL_ENV}"

		export PS1="${ps1_color_reset}${ps1_status:+${PS1_ERROR_COLOR} ${ps1_status} ${ps1_color_reset}}${PS1_OK_COLOR}${ps1_virtual_env:+(${ps1_virtual_env})} \W${PS1_GIT:+ :${PS1_GIT}}\$ ${ps1_color_reset} "
	}

	export PROMPT_COMMAND=__prompt_command
}

__export_functions () {
	if [[ -r ~/.local/bin/partialcd ]]; then
		export -f _partialcd
	fi
	export -f pyenv
	export -f __prompt_command
	export -f __ps1_git
}


__main () {
	if [[ -z "${OSNAME}" ]]; then
		export OSNAME="$(uname)"
	fi

	__aliases
	__shell_options

	if [[ -n "${LOADED_ENV}" ]]; then
		return
	fi
	export LOADED_ENV=1

	__variables
	__define_functions
	__export_functions
}

__main

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
