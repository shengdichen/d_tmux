# component {{{
# first line, center {{{
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
# }}}

set-option -gw window-status-separator "|"
# }}}

# style {{{
set-option -g status-justify centre

set-option -g status-style \
"bg=terminal fg=terminal nobold"

# do NOT auto-redraw
set-option -g status-interval 0
# }}}

# vim: filetype=tmux foldmethod=marker
