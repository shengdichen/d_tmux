# status-line {{{
set-option -g status-format[0] ""
set-option -g -a status-format[0] "#[align=absolute-centre] "
set-option -g -a status-format[0] \
"#[bg=terminal fg=colour007]#{W:\
#[bg=terminal fg=colour007]/ #{?window_last_flag,-,}#{=/-9[*]:window_name} /\
,\
/ \
#[bg=terminal fg=terminal bold]#{session_name}:#{=/-15/[*]:window_name}.#{pane_index}#{?window_zoomed_flag,z,}\
#[bg=terminal fg=colour007 nobold] /\
}"

set-option -g status on
set-option -g status-position bottom
# }}}

set-option -gw pane-border-status off

# vim: filetype=tmux
