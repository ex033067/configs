#!/usr/bin/env bash

# Script tested only in Ubuntu 20.04

# Use the desktop environment.
# We need it to see the new wallpaper change in real time.
PID=$(pgrep gnome-session -n -U $UID)
ENVVARS_LIST=$(cat -e "/proc/${PID}/environ" 2>/dev/null | sed 's/\^@/\n/g' | tr -d '\0')
for var in $ENVVARS_LIST; do
    export $var
done

NOW=$(date "+%F %T")
SOURCE_DIR=${HOME}/.local/share/backgrounds
CURRENT_WALLPAPER=$(gsettings get org.gnome.desktop.background picture-uri | sed -e 's/file:\/\///' -e "s/'//g")
WALLPAPERS=(${SOURCE_DIR}/auto-wallpapers-*)
FOUND=
NEW_WALLPAPER=

if [[ -r "${SOURCE_DIR}/auto-wallpapers.disabled" ]]; then
    echo ""
    echo "${NOW} - Found file ${SOURCE}/auto-wallppers.disabled. Exiting."
    exit
fi

echo ""
echo "${NOW} - current wallpaper: $CURRENT_WALLPAPER"

for i in ${!WALLPAPERS[@]}; do
    if [[ -n "${FOUND}" ]]; then
        NEW_WALLPAPER="${WALLPAPERS[$i]}"
        echo "${NOW} - new wallpaper ${NEW_WALLPAPER}"
        break
    elif [[ "${WALLPAPERS[$i]}" = "${CURRENT_WALLPAPER}" ]]; then
        FOUND=1
    fi
done

if [[ -z "${FOUND}" ]]; then
    echo "${NOW} - wallpaper is not automatic. Exiting."
    exit 1
fi

if [[ -z "${NEW_WALLPAPER}" ]]; then
    echo "${NOW} - starting from the beginning"
    NEW_WALLPAPER="${WALLPAPERS[0]}"
fi

echo "${NOW} - configuring new wallpaper ${NEW_WALLPAPER}"
gsettings set org.gnome.desktop.background picture-uri "file://${NEW_WALLPAPER}"
