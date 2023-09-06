set-option -g default-shell /bin/zsh
set-option -g default-command ""

# use 1-indexing for windows
set-option -g base-index 1
set-option -g renumber-windows on

# do NOT kill session if unattached
set-option -g destroy-unattached off
# switch to previous session instead of detaching if current session is killed
set-option -g detach-on-destroy off

# notification {{{
# which windows to consider for events
# NOTE:
#   1. definition:
#   none: on none of the windows
#   current: only on currently active window
#   other: on all other window(s) except the current one
#.  any: on any window
#   2. setting |*-action| to |none| is equivalent to setting |monitor-*| to
#   |off|
#   3. how tmux handles these events is given by |visual-*|
set-option -g activity-action other
set-option -g bell-action any
set-option -g silence-action none  # do NOT monitor silence

# handling of events
# NOTE:
#   1. definition
#   on:     display message on status-line
#   off:    flash screen by sending a bell
#   both:   dispaly message on statue-line AND flash screen by sending a bell
set-option -g visual-activity on
set-option -g visual-bell off
set-option -g visual-silence on  # throwaway: |silence| is NOT monitored anyway
# }}}

# input {{{
#   key-table key-table
#   Set the default key table to key-table instead of root.
#
#       set-option -g key-table root

set-option -g mouse off

# bind for |prefix| table
set-option -g prefix C-b
set-option -g prefix2 M-Space

set-option -g repeat-time 500  # time before prefix-key is required again
# }}}

# style {{{
# pane-numbers for current window (invoke with |:display-panes|)
set-option -g display-panes-active-colour colour015
set-option -g display-panes-colour colour007
set-option -g display-panes-time 750

set-option -g message-command-style \
"bg=terminal fg=terminal bold italics"

set-option -g message-style \
"bg=terminal fg=terminal bold italics"
# }}}

set-option -g status-keys vi  # in status-line
set-option -g history-limit 10000
set-option -g display-time 0  # do NOT auto-hide messages

# vim: filetype=tmux foldmethod=marker
