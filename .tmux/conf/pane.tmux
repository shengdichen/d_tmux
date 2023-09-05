# the active pane
set-option -gw window-active-style \
"bg=colour016 fg=#ede3f7"

# all inactive panes
set-option -gw window-style \
"bg=colour237 fg=colour239"

# do NOT auto-rename window
set-option -gw allow-rename off

# do NOT kill pane when its program exits:
#   1. respawn with |:respawn-pane|
#   2. force-kill with |:kill-pane|
set-option -gw remain-on-exit on

# misc {{{
#   alternate-screen
# }}}

# vim: filetype=tmux foldmethod=marker
