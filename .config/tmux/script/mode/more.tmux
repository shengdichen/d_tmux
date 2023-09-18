# status-line {{{
set-option -g status-format[0] ""
set-option -g -a status-format[0] "#[align=left] "
set-option -g -a status-format[0] \
"#{window_index}/#{session_windows}"
set-option -g -a status-format[0] "  >"
set-option -g -a status-format[0] \
"#{W:\
/#[#{E:window-status-style}]#{E:window-status-format}/\
,\
/#[#{E:window-status-current-style}]#{E:window-status-current-format}#[default]/\
}#[default]"

set-option -g -a status-format[0] "#[align=right]"
set-option -g -a status-format[0] "#{client_tty}"
set-option -g -a status-format[0] "  "
set-option -g -a status-format[0] "("
set-option -g -a status-format[0] "#{session_name}"
set-option -g -a status-format[0] \
"#{?session_many_attached,(#[fg=colour001]#{session_attached}#[default]),}"
set-option -g -a status-format[0] ", "
set-option -g -a status-format[0] "#{session_id},#{window_id},#{pane_id}"
set-option -g -a status-format[0] ")"
# }}}

# show two lines
set-option -g status 2

set-option -g status-position bottom
# }}}

set-option -gw pane-border-status bottom

# vim: filetype=tmux foldmethod=marker
