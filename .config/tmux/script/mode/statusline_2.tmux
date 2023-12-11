# NOTE:
#   grey    := #[#{E:window-status-style}]
#   white   := #[#{E:status-style}]
#   bold    := #[#{E:window-status-current-style}]

set-option -g status on
set-option -g status-position bottom

# component {{{
set-option -g status-format[0] ""

# LHS {{{
set-option -g -a status-format[0] "#[align=left]"

# session
# show session-group if existent, otherwise session-name
set-option -g -a status-format[0] "#[#{E:status-style}]\
#{?session_grouped,#{session_group},#{session_name}}\
"
set-option -g -a status-format[0] "#[#{E:window-status-style}]: "

# all windows
set-option -g -a status-format[0] "#[#{E:window-status-style}]\
#{W:\
#[#{E:window-status-style}]/ #{?window_last_flag,-,}#{=/-9[*]:window_name} /\
,\
#[#{E:window-status-style}]/ \
#[#{E:window-status-current-style}]#{=/-15/[*]:window_name}\
#{?window_zoomed_flag,#[#{E:window-status-style}].#[#{E:status-style}]#{pane_index},}\
#[#{E:window-status-style}] /\
}"
# }}}

# RHS {{{
set-option -g -a status-format[0] "#[align=right]"

# host>tty
set-option -g -a status-format[0] "#[#{E:status-style}]#{host}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]>"
set-option -g -a status-format[0] "#[#{E:window-status-style}]#{pane_tty}"
set-option -g -a status-format[0] "#[#{E:window-status-style}]  "

set-option -g -a status-format[0] "#[#{E:window-status-style}]("
# session
# session-group {{{
# NOTE:
#   if in session-group:
#       if session-group-size > 1:
#           if session-name == session-group:
#               out = "[grey]session-name/session-group-size:"
#           else:
#               out = "[bold]session-name/session-group-size:"
#       else:
#           if session-name != session-group:
#               out = "session-name:"
set-option -g -a status-format[0] "#{?\
session_grouped,\
#{?\
#{>:#{session_group_size},1},\
#{?\
#{==:#{session_name},#{session_group}},\
#[#{E:window-status-style}]\
,\
#[#{E:window-status-current-style}]\
}#{session_name}\
#[#{E:window-status-style}]/#{session_group_size}\
#[#{E:window-status-style}]:\
,\
#{?\
#{!=:#{session_name},#{session_group}},\
#[#{E:window-status-current-style}]#{session_name}\
#[#{E:window-status-style}]:\
,\
}\
}\
,\
}"
# }}}
set-option -g -a status-format[0] "#[#{E:window-status-style}]#{session_id}"
# indicate (only) if multi-attached
set-option -g -a status-format[0] "#{\
?session_many_attached,\
#[#{E:status-style}](\
#[fg=colour001]#{session_attached}\
#[#{E:status-style}])\
,\
}"

set-option -g -a status-format[0] "#[#{E:window-status-style}], "  # separator

# window
set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{window_index}\
#[#{E:window-status-style}]/\
#[#{E:status-status-style}]#{session_windows}\
#[#{E:window-status-style}]:\
#[#{E:window-status-style}]#{window_id}\
"

set-option -g -a status-format[0] "#[#{E:window-status-style}], "  # separator

# pane
set-option -g -a status-format[0] "\
#[#{E:window-status-current-style}]#{pane_index}\
#[#{E:window-status-style}]/\
#[#{E:window-status-style}]#{window_panes}\
#[#{E:window-status-style}]:\
#[#{E:window-status-style}]#{pane_id}\
"
set-option -g -a status-format[0] "#[#{E:window-status-style}])"
# }}}

set-option -g -a status-format[0] "#[#{E:status-style}]"
# }}}

# vim: filetype=tmux foldmethod=marker
