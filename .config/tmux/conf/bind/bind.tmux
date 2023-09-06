# default key-table
set-option -g key-table default

# NOTE:
#   1. should generally reuse the prefix itself: inputting the prefix twice
#   will send it directly (instead of being processed by tmux)
bind-key -T prefix M-Space send-prefix

# vim: filetype=tmux
