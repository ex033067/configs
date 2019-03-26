#  vim: filetype=sh

if [ -d ~/.local/bin/pyenv ]; then
    export PYENV_ROOT=~/.local/bin/pyenv
else
    export PYENV_ROOT=~/.pyenv
fi

export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv > /dev/null
then
    eval "$(pyenv init -)"
    pyenv global 3.7.2 2.7.14 tools jupyter
fi
