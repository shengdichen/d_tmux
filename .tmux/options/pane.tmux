# the active pane
set-option -gw window-active-style '\
fg='#ede3f7' \
bg=colour016 \
'
# all inactive panes
set-option -gw window-style '\
fg=colour239 \
bg=colour237 \
'

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
