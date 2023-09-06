# component {{{
# first line, extra {{{
set-option -g status-left '\
[(#{session_name})->\
#{?#{==:#{client_key_table},root},\
\
#[fg=colour009]Rt,\
\
#{?#{==:#{client_key_table},prefix},\
#[fg=colour005 reverse]Px,\
#[default]#{client_key_table}\
}\
\
}#[default]\
] > {#{client_tty}}\
'
set -g status-left-length 40
#   status-left-style style

set -g status-right '\
Nº(#{?session_many_attached,#[fg=colour001],}#{session_attached}\
#[default],#{session_windows},#{window_panes})/\
∑(#{session_id},#{window_id},#{pane_id})\
'
set -g status-right-length 40
#   status-right-style style
# }}}

# second line {{{
set-option -g status-format[1] '\
#[align=centre]\
#{?client_prefix,\
\
[prefixed@#{client_key_table}],\
\
#{W:#{?window_active,\
#[#{E:window-status-current-style}][#{=/-15/[*]:window_name}#,#{window_flags}],\
#[#{E:window-status-style}]#{=/-9/[*]:window_name}#{?window_flags,#,#{window_flags},}}\
#[default]#{?window_end_flag,, | }\
}\
\
}\
'

# NOTE: default
#       set-option -g status-format[1] "\
#[align=centre]#{P:#{?pane_active,#[reverse],}#{pane_index}\
[#{pane_width}x#{pane_height}]#[default] }\
"
# }}}
# }}}

# show two lines
set-option -g status 2

set-option -g status-position top

# vim: filetype=tmux foldmethod=marker
