# status-line {{{
set-option -g status-format[0] ""
set-option -g -a status-format[0] "#[align=left] "
set-option -g -a status-format[0] "#{session_name}"
set-option -g -a status-format[0] \
"#{?session_many_attached,(#[fg=colour001]#{session_attached}#[default]),}"
set-option -g -a status-format[0] " > "
set-option -g -a status-format[0] \
"#{W:\
/#[bg=terminal fg=colour007]#{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},}#[default]/\
,\
/#[bg=terminal fg=terminal bold]#{session_windows}.#{window_index} #{=/-15/[*]:window_name},#{window_flags}#[default]/\
}"

set-option -g -a status-format[0] "#[align=right]"
set-option -g -a status-format[0] "  "
set-option -g -a status-format[0] "("
set-option -g -a status-format[0] "#{client_tty}"
set-option -g -a status-format[0] ", "
set-option -g -a status-format[0] "#{session_id},#{window_id},#{pane_id}"
set-option -g -a status-format[0] ") "

set-option -g status on

set-option -g status-position bottom
# }}}

set-option -gw pane-border-status bottom

# vim: filetype=tmux foldmethod=marker
