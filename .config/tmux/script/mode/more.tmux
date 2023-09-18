# status-line {{{
set-option -g status-format[0] ""
set-option -g -a status-format[0] "#[align=left]"
set-option -g -a status-format[0] "#{host}"
set-option -g -a status-format[0] "#[bg=terminal fg=colour007]:#[default] "
set-option -g -a status-format[0] \
"#[bg=terminal fg=colour007]#{W:\
#[bg=terminal fg=colour007]/ #{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},} /\
,\
/ \
#[bg=terminal fg=terminal bold]#{=/-15/[*]:window_name},#{window_flags}\
#[bg=terminal fg=colour007 nobold] /\
}#[default]"

set-option -g -a status-format[0] "#[align=right]"
set-option -g -a status-format[0] "#[bg=terminal fg=colour007]>#[default]"
set-option -g -a status-format[0] "#{client_tty}"
set-option -g -a status-format[0] "  "
set-option -g -a status-format[0] "#[bg=terminal fg=colour007](#[default]"
set-option -g -a status-format[0] "#{session_name}"
set-option -g -a status-format[0] \
"#{?session_many_attached,(#[fg=colour001]#{session_attached}#[default]),}"
set-option -g -a status-format[0] "/#{session_id}"
set-option -g -a status-format[0] "#[bg=terminal fg=colour007], #[default]"
set-option -g -a status-format[0] "#{window_index}/#{session_windows}/#{window_id}"
set-option -g -a status-format[0] "#[bg=terminal fg=colour007], #[default]"
set-option -g -a status-format[0] "#{pane_index}/#{window_panes}/#{pane_id}"
set-option -g -a status-format[0] "#[bg=terminal fg=colour007])#[default]"

set-option -g status on

set-option -g status-position bottom
# }}}

set-option -gw pane-border-status top

# vim: filetype=tmux foldmethod=marker
