#  vim: filetype=sh

if which autoenvrc > /dev/null
then
    eval "$(autoenvrc init)"
fi


# IMPORTANT NOTE
#
# Why are we sourcing .env file again if it was alread sourced in autoenvrc?
#
# Short answer:
#
# Because .bashrc is run when execing $SHELL to retain the interactive session
# and it overrides settings made by the .env file.
#
# Long answer:
#
# The workflow is:
#
#   1) Detect a directory with a .env file when cd'ing into it.
#
#   2) Open a subshell interactive session.
#
#   3) Source the .env file.
#
#   4) Activate the virtualenv (using an envvar from .env file above).
#
#   5) "exec $SHELL" to retain the interactive session.
#
# When execing $SHELL, ~/.bashrc is executed again. What does it mean?  It
# means ~/.bashrc may override aliases and envvars set previously by the .env
# file.
#
# Since the .env file is set in a project basis, it must override global
# settings made in .bashrc. That's why we need to source it again, after all
# variables and aliases.
#
# I realized this behaviour when setting an alias in a .env file, to override
# the global alias with same name, but the global alias was still in place.

if [ -n "$AUTOENVRC_LOADED" ] && [ -f $PWD/$AUTOENVRC_FILE ]; then
    source $PWD/$AUTOENVRC_FILE
    echo ".bashrc: sourced \$PWD/$AUTOENVRC_FILE again to override aliases and envvars"
fi
