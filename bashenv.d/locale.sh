#  vim: filetype=sh

# Set default locale.
# OS X works with "UTF-8" only by default, what makes python crash.
[ "$(uname)" = "Darwin" ] && export LC_CTYPE="en_US.UTF-8"
