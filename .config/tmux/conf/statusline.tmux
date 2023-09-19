set-option -g status-style \
"bg=terminal fg=terminal nobold"

# do NOT auto-redraw
set-option -g status-interval 0

# auto first-line {{{
set-option -g status-justify absolute-centre

# the current window
set-option -g -w window-status-current-format ""  # specify manually
set-option -g -w window-status-current-style \
"bg=terminal fg=terminal bold"

# all inactive windows
set-option -g -w window-status-format ""  # specify manually
set-option -g -w window-status-style \
"bg=terminal fg=colour007 nobold"

set-option -g -w window-status-activity-style \
"bg=terminal fg=colour006"
set-option -g -w window-status-bell-style \
"bg=terminal fg=colour001"

# separator between (current & inactive) windows
set-option -gw window-status-separator "|"
# }}}

# vim: filetype=tmux foldmethod=marker
