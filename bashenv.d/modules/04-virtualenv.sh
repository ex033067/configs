#  vim: filetype=sh

if [ -d ~/.local/bin/virtualenvs ]; then
    export VIRTUAL_ENV_ROOT=~/.local/bin/virtualenvs
else
    export VIRTUAL_ENV_ROOT=~/virtualenvs
fi

if [ -n "$VIRTUAL_ENV" ]; then
    export PATH="$VIRTUAL_ENV/bin:$PATH"
fi
