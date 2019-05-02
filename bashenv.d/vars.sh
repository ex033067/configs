#  vim: filetype=sh

export PROJECT_ROOT=~/projects

[ -z "$TMPDIR" ] && export TMPDIR=/tmp

export HISTCONTROL=ignoreboth
if [[ "$(uname)" = "Darwin" ]]; then
	export EDITOR='nvim'
else
	export EDITOR='nvim.appimage'
fi
export VISUAL=$EDITOR
