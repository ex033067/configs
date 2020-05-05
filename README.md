# Vinicius' dotfiles #

## Installation ##

Run:

```
$ make install
```


## Notes ##

Customizations:

- Your git credentials: `~/.gitconfig_credentials`
- Bash prompt colors: `~/.ps1_colors`
- Alias to your hostname in bash prompt: `~/.ps1_hostname_alias`
- Alias to your hostname in tmux status bar: `~/.tmux_hostname`
- Pyenv global config: `~/.pyenv_global_command`


Neovim directories:

| What         | Where                              | Example                 |
|--------------|------------------------------------|-------------------------|
| Config       | `${XDG_CONFIG_HOME}/nvim/init.vim` | `~/.config/nvim/init.vim` |
| Data files   | `${XDG_DATA_HOME}/nvim/`           | `~/.local/share/nvim` |
| Plugins      | `${XDG_DATA_HOME}/nvim/vim-plug`   | each plugin in its own directory |

Reference for XDG directories: <https://specifications.freedesktop.org/basedir-spec/0.6/ar01s03.html>

