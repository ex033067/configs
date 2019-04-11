#  vim: filetype=sh

alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'

alias ll='ls -lh'

[ "$(uname)" = "Darwin" ] && alias ls='ls -Gp'
[ "$(uname)" = "Linux" ] && alias ls='ls -p --group-directories-first --color=auto'

alias ack='ack --sort-files --color-filename="bold blue" --color-lineno="blue" --color-match="bold white on_blue" --ignore-dir=is:.venv'
alias grep='grep --color=auto'

alias django='python manage.py'
alias nb='jupyter notebook --ip=localhost.test'

alias clog='${PROJECT_ROOT}/clog/clog.sh'
alias now='date -u +%y%m%d%H%M'

alias todo='cd ~/Dropbox/todo && vim todo.todo'

# one-letters
alias l='ls -lhgo'
alias r='runserver'
alias t='make test'
