set-option -g status on
set-option -g status-position bottom

# component {{{
set-option -g status-format[0] ""

# LHS {{{
set-option -g -a status-format[0] "#[align=left]"

# host
set-option -g -a status-format[0] "#[#{E:status-style}]#{host}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]: "

# all windows
set-option -g -a status-format[0] "#[#{E:window-status-style}]\
#{W:\
#[#{E:window-status-style}]/ #{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},} /\
,\
#[#{E:window-status-style}]/ \
#[#{E:window-status-current-style}]#{=/-15/[*]:window_name}\
#{?window_flags,#[#{E:window-status-style}]#,#[#{E:status-style}]#{window_flags},}\
#[#{E:window-status-style}] /\
}"
# }}}

# RHS {{{
set-option -g -a status-format[0] "#[align=right]"

# tty
set-option -g -a status-format[0] "#[#{E:window-status-style}]>"
set-option -g -a status-format[0] "#[#{E:status-style}]#{client_tty}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]  "

set-option -g -a status-format[0] "#[#{E:window-status-style}]("
# session
set-option -g -a status-format[0] "#[#{E:window-status-current-style}]#{session_name}"
set-option -g -a status-format[0] "#{\
?session_many_attached,\
#[#{E:status-style}](\
#[fg=colour001]#{session_attached}\
#[#{E:status-style}])\
,\
}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]/"
set-option -g -a status-format[0] "#[#{E:window-status-style}]#{session_id}"

set-option -g -a status-format[0] "#[#{E:window-status-style}], "  # separator

# window
set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{window_index}\
#[#{E:window-status-style}]/\
#[#{E:status-status-style}]#{session_windows}\
#[#{E:window-status-style}]/\
#[#{E:window-status-style}]#{window_id}\
"

set-option -g -a status-format[0] "#[#{E:window-status-style}], "  # separator

# pane
set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{pane_index}\
#[#{E:window-status-style}]/\
#[#{E:window-status-style}]#{window_panes}\
#[#{E:window-status-style}]/\
#[#{E:window-status-style}]#{pane_id}\
"
set-option -g -a status-format[0] "#[#{E:window-status-style}])"
# }}}

set-option -g -a status-format[0] "#[#{E:status-style}]"
# }}}

# vim: filetype=tmux foldmethod=marker
