Backup of Tilix configs
=======================

_Tilix_ uses `dconf` to manage configuration. So, there isn't a "config
file".

Exporting your current config:

    $ dconf dump /com/gexperts/Tilix/ > config.txt

Importing configs:

    $ dconf load /com/gexperts/Tilix/ < config.txt

Resetting configs:

    $ dconf reset -f /com/gexperts/Tilix/

