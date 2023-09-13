set-option -s default-terminal "tmux-256color"

# as recommended by neovim
set-option -s escape-time 300
set-option -s focus-events on

# do NOT exit server if no active session; instead, force with:
#   :kill-server
set-option -s exit-empty off

# do NOT exit server if no attached client
set-option -s exit-unattached off

set-option -sgu terminal-overrides
set-option -sga terminal-overrides ',*:XT'
set-option -sga terminal-overrides ',*:Ms=\E]52;%p1%s;%p2%s\007'
set-option -sga terminal-overrides ',*:Cs=\E]12;%p1%s\007:Cr=\E]112\007'
# https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-rgb-colour
set-option -sga terminal-overrides ",*256color*:Tc,foot:Tc"
set-option -sga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'

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
