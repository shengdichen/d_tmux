# default key-table
set-option -g key-table default

# NOTE:
#   1. should generally reuse the prefix itself: inputting the prefix twice
#   will send it directly (instead of being processed by tmux)
bind-key -T prefix C-b send-prefix
bind-key -T prefix M-Space send-prefix -2

unbind-key -a -q -T defTab

source-file ~/.tmux/conf/bind/table/prefix.tmux
source-file ~/.tmux/conf/bind/table/default.tmux

# vim: filetype=tmux foldmethod=marker
