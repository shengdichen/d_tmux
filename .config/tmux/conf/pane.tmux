# the active pane
set-option -g -w window-active-style \
"bg=terminal fg=terminal"

# all inactive panes
set-option -g -w window-style \
"bg=colour008 fg=terminal"

# do NOT auto-rename window
set-option -g -w allow-rename off

# do NOT kill pane when its program exits:
#   1. respawn with |:respawn-pane|
#   2. force-kill with |:kill-pane|
set-option -g -w remain-on-exit on

# misc {{{
#   alternate-screen
# }}}

# vim: filetype=tmux foldmethod=marker
