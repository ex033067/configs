# Auto change wallpaper

Note: script tested only in Ubuntu 20.04

## Creating the images

```
$ pdftocairo -png auto-wallpapers.pdf
$ mv auto-wallpapers*.png ~/.local/share/backgrounds/
```

## Running the script automatically

Use `crontab -e` to add the entry below in your personal crontab and change the wallpaper on every 5 minutes:

```
SHELL=/bin/bash
*/5 * * * *   /full/path/to/the/script/auto-change-wallpaper.sh >> /tmp/auto-change-wallpaper.log 2>&1
```

Notice you must write the correct path to the script.

The script will only change your wallpaper when one automatic is set. Thus, to start the process, you must go to Ubuntu Settings and set one of them.

You can create the file `~/.local/share/backgrounds/auto-wallpapers.disabled` to disable the routine.
