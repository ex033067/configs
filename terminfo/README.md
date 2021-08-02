Terminfo
========

I use it with iTerm2 in MacOS. In Linux I don't need this because I use gnome-terminal or Tilix.

Read [Italic fonts in iTerm2, tmux, and vim](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/) for reference.

Test if your terminal supports italic:

    $ echo `tput sitm`italics`tput ritm`

If not, build terminfo:

    $ tic xterm-256color.terminfo

Terminfo will be compiled to some subdir under `~/.terminfo/`.

To remove a specific terminfo, find it with `find` and remove it.
