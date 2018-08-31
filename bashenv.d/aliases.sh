#  vim: filetype=sh

alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias e='vim'

alias ll='ls -lh'
alias l1='ls -1'

[ "$(uname)" = "Darwin" ] && alias ls='ls -Gp'
[ "$(uname)" = "Linux" ] && alias ls='ls -p --group-directories-first --color=auto'

alias ack='ack --sort-files --color-filename="bold blue" --color-lineno="blue" --color-match="bold white on_blue"'
alias grep='grep --color=auto'

alias django='python manage.py'
alias nb='pyenv shell jupyter;jupyter notebook'

alias docstyle='pydocstyle -e --count --ignore=D103 '
alias lint='pylint -rn --disable=missing-docstring '

alias pt='py.test'
alias st='python setup.py test'
alias ut='python -m unittest'

alias clog='${PROJECT_ROOT}/clog/clog.sh'
alias now='date -u +%y%m%d%H%M'

alias todo='cd ~/Dropbox/todo && vim todo.todo'

# one-letters
alias l='ls -lhgo'
alias r='runserver'
alias t='make test'
