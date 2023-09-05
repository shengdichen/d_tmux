# default key-table
set-option -g key-table default

# NOTE:
#   1. should generally reuse the prefix itself: inputting the prefix twice
#   will send it directly (instead of being processed by tmux)
bind-key -T prefix C-b send-prefix
bind-key -T prefix M-Space send-prefix -2

unbind-key -a -q -T defTab

source-file ~/.tmux/bindings/tables/prefix-table.tmux
source-file ~/.tmux/bindings/tables/default.tmux

# vim: filetype=tmux foldmethod=marker
