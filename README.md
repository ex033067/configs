# All my configs #

This is a mono-repo.


## Installation ##

Run:

```
$ make install
```


## Notes ##

Customizations:

| File                        | What                    |
|-----------------------------|-------------------------|
| `~/.gitconfig_credentials`  | Your git credentials |
| `~/.ps1_colors`             | Bash prompt colors |
| `~/.ps1_hostname_alias`     | Alias to your hostname in bash prompt |
| `~/.tmux_hostname`          | Alias to your hostname in tmux status bar |
| `~/.pyenv_global_command`   | Pyenv global config |


Neovim directories:

| What         | Where                              | Example                 |
|--------------|------------------------------------|-------------------------|
| Config       | `${XDG_CONFIG_HOME}/nvim/init.vim` | `~/.config/nvim/init.vim` |
| Data files   | `${XDG_DATA_HOME}/nvim/`           | `~/.local/share/nvim` |
| Plugins      | `${XDG_DATA_HOME}/nvim/vim-plug`   | each plugin in its own directory |

Reference for XDG directories: <https://specifications.freedesktop.org/basedir-spec/0.6/ar01s03.html>

