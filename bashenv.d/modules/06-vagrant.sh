#  vim: filetype=sh

if [[ -d /Volumes/hd2/${USER}/.vagrant.d ]]; then
    export VAGRANT_HOME=/Volumes/hd2/${USER}/.vagrant.d
fi

export VAGRANT_BOX_UPDATE_CHECK_DISABLE=1
