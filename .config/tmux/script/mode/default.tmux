# status-line {{{
set-option -g status-format[0] ""
set-option -g -a status-format[0] "#[align=absolute-centre] "
set-option -g -a status-format[0] \
"#{W:\
#[bg=terminal fg=colour007]/ #{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},} /\
,\
/ \
#[bg=terminal fg=terminal bold]#{session_name}:#{=/-15/[*]:window_name}.#{pane_index}\
#[bg=terminal fg=colour007 nobold] /\
}"

set-option -g status on
set-option -g status-position bottom
# }}}

set-option -gw pane-border-status off

# vim: filetype=tmux
