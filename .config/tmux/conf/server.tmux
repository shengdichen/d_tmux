set-option -g -s default-terminal "xterm-256color"

# as recommended by neovim
set-option -g -s escape-time 300
set-option -g -s focus-events on

# do NOT exit server if no active session; instead, force with:
#   :kill-server
set-option -g -s exit-empty off

# do NOT exit server if no attached client
set-option -g -s exit-unattached off

set-option -g -s -u terminal-overrides
set-option -g -s -a terminal-overrides ',*:XT'
set-option -g -s -a terminal-overrides ',*:Ms=\E]52;%p1%s;%p2%s\007'
set-option -g -s -a terminal-overrides ',*:Cs=\E]12;%p1%s\007:Cr=\E]112\007'
# https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour
set-option -g -s -a terminal-overrides ",*256color*:Tc,foot:Tc"
set-option -g -s -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

# misc {{{
#   buffer-limit
#   message-limit

#   command-alias
#   focus-events

#   history-file
#   set-clipboard

#   user-keys
# }}}

# vim: filetype=tmux foldmethod=marker
