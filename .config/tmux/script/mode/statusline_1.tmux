set-option -g status on
set-option -g status-position bottom

# component {{{
set-option -g status-format[0] ""

set-option -g -a status-format[0] "#[align=absolute-centre] "

# all windows
set-option -g -a status-format[0] "#[#{E:window-status-style}]"\
"#{W:\
#[#{E:window-status-style}]/ #{?window_last_flag,-,}#{=/-9[*]:window_name} /\
,\
#[#{E:window-status-style}]/ \
#[#{E:status-style}]#{session_name}\
#[#{E:window-status-style}]:\
#[#{E:window-status-current-style}]#{=/-15/[*]:window_name}\
#{?window_zoomed_flag,#[#{E:window-status-style}].#[#{E:status-style}]#{pane_index},}\
#[#{E:window-status-style}] /\
}"

set-option -g -a status-format[0] "#[#{E:status-style}]"
# }}}

# vim: filetype=tmux foldmethod=marker
