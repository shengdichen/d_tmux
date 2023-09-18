# status-line {{{
set-option -g status-format[0] ""
set-option -g -a status-format[0] "#[align=absolute-centre] "
set-option -g -a status-format[0] "#[#{E:window-status-style}]"
set-option -g -a status-format[0] \
"#{W:\
#[#{E:window-status-style}]/ #{?window_last_flag,-,}#{=/-9[*]:window_name} /\
,\
/ \
#[#{E:window-status-current-style}]#{session_name}:#{=/-15/[*]:window_name}.#{pane_index}#{?window_zoomed_flag,z,}\
#[#{E:window-status-style}] /\
}"

set-option -g -a status-format[0] "#[#{E:window-status-current-style}]"

set-option -g status on
set-option -g status-position bottom
# }}}

set-option -gw pane-border-status off

# vim: filetype=tmux
