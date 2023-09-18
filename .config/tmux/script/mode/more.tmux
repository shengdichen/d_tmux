# status-line {{{
set-option -g status-format[0] ""

set-option -g -a status-format[0] "#[#{E:window-status-current-style} align=left]"
set-option -g -a status-format[0] "#{host}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]: "
set-option -g -a status-format[0] \
"#[#{E:window-status-style}]#{W:\
#[#{E:window-status-style}]/ #{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},} /\
,\
/ \
#[#{E:window-status-current-style}]#{=/-15/[*]:window_name},#{window_flags}\
#[#{E:window-status-style}] /\
}"

set-option -g -a status-format[0] "#[#{E:window-status-current-style} align=right]"
set-option -g -a status-format[0] "#[#{E:window-status-style}]>"
set-option -g -a status-format[0] "#[#{E:window-status-current-style}]#{client_tty}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]  "

set-option -g -a status-format[0] "#[#{E:window-status-style}]("
set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{session_name}"\
"#{?session_many_attached,(#[fg=colour001]#{session_attached}#[#{E:window-status-current-style}]),}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]/"
set-option -g -a status-format[0] "#[#{E:window-status-current-style}]#{session_id}"

set-option -g -a status-format[0] "#[#{E:window-status-style}], "

set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{window_index}\
#[#{E:window-status-style}]/\
#[#{E:window-status-current-style}]#{session_windows}\
#[#{E:window-status-style}]/\
#[#{E:window-status-current-style}]#{window_id}\
"

set-option -g -a status-format[0] "#[#{E:window-status-style}], "

set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{pane_index}\
#[#{E:window-status-style}]/\
#[#{E:window-status-current-style}]#{window_panes}\
#[#{E:window-status-style}]/\
#[#{E:window-status-current-style}]#{pane_id}\
"
set-option -g -a status-format[0] "#[#{E:window-status-style}])"

set-option -g -a status-format[0] "#[#{E:window-status-current-style}]"

set-option -g status on

set-option -g status-position bottom
# }}}

set-option -gw pane-border-status top

# vim: filetype=tmux foldmethod=marker
