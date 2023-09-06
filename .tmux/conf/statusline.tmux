# component {{{
# first line, center {{{
# the current window
set-option -gw window-status-current-format " \
[#{=/-15/[*]:window_name},#{window_flags}] \
"
set-option -gw window-status-current-style \
"bg=terminal fg=terminal bold"

# all inactive windows
set-option -gw window-status-format " \
#{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},} \
"
set-option -gw window-status-style \
"bg=terminal fg=colour007"

set-option -gw window-status-activity-style \
"bg=terminal fg=colour006"
set-option -gw window-status-bell-style \
"bg=terminal fg=colour001"
# }}}

set-option -gw window-status-separator "|"
# }}}

# style {{{
set-option -g status-justify centre

set-option -g status-style \
"bg=terminal fg=terminal"

# do NOT auto-redraw
set-option -g status-interval 0
# }}}

# vim: filetype=tmux foldmethod=marker
