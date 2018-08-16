#  vim: filetype=sh

if which pyenv > /dev/null
then
    eval "$(pyenv init -)"
    pyenv global 3.6.5 2.7.14 tools jupyter
fi
