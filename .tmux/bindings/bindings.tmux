# default key-table
set-option -g key-table modTab

# NOTE:
#   1. should generally reuse the prefix itself: inputting the prefix twice
#   will send it directly (instead of being processed by tmux)
bind-key -T prefix C-b send-prefix
bind-key -T prefix M-Space send-prefix -2

# reset key-tables
# NOTE:
#   1. -a
#   unset all binds of the key-table
#   2.  -q
#   fail silently: suppress warning when starting server, as these non-default
#   key-tables do not yet exist
unbind-key -a -q -T defTab
unbind-key -a -q -T modTab

source-file ~/.tmux/bindings/tables/prefix-table.tmux
source-file ~/.tmux/bindings/tables/defTab-table.tmux
source-file ~/.tmux/bindings/tables/modTab-table.tmux

# vim: filetype=tmux foldmethod=marker
