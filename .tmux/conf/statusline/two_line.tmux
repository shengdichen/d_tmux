# Window-Status Component {{{

# NOTICE:
# This section specifies a special Component of the status-line that traverses
# all the WINDOWs of the current session automatically, the positioning of
# which is determined by the SESSION OPTION:
#       |status-justify|
# set later in the Status-Line section. Beware that this is limited to the
# FIRST line of the status-line only.


#   window-status-separator string
#   Sets the separator drawn between windows in the status line. The default is a
#   single space character.
#
set-option -gw window-status-separator ''


# currently active window {{{
#   window-status-current-format string
#   Like window-status-format, but is the format used when the window is the
#   current window.
#
#   window-status-current-style style
#   Set status line style for the currently active window. For how to specify
#   style, see the STYLES section.
#
# status for the currently active window
set-option -gw window-status-current-format ''
#       set-option -gw window-status-current-format ' \
#       [#{=/-15/[*]:window_name},#{window_flags}] \
'

set-option -gw window-status-current-style 'fg=colour015 bg=colour16 bold'
# }}}


# special windows {{{

#   window-status-last-style style
#   Set status line style for the last active window. For how to specify style, see
#   the STYLES section.
#

#   window-status-activity-style style
#   Set status line style for windows with an activity alert. For how to specify
#   style, see the STYLES section.
#
set-option -gw window-status-activity-style 'fg=colour006 bg=colour016'

#   window-status-bell-style style
#   Set status line style for windows with a bell alert. For how to specify style,
#   see the STYLES section.
#
set-option -gw window-status-bell-style 'fg=colour001 bg=colour016'

# }}}


# currently inactive window {{{

#   window-status-format string
#   Set the format in which the window is displayed in the status line window list.
#   See the FORMATS and STYLES sections.
#
#   window-status-style style
#   Set status line style for a single window. For how to specify style, see the
#   STYLES section.
#
# status for all currently inactive windows
set-option -gw window-status-format ''
#       set-option -gw window-status-format ' \
#       #{=/-9[*]:window_name}#{?window_flags,#,#{window_flags},} \
'

set-option -gw window-status-style 'fg=colour243 bg=colour016'

# }}}

# }}}



# Status-Line {{{

# set-up {{{

#   status [off | on | 2 | 3 | 4 | 5]
#   Show or hide the status line or specify its size. Using on gives a status
#   line one row in height; 2, 3, 4 or 5 more rows.
#
set-option -g status 2


#   status-interval interval
#   Update the status line every interval seconds. By default, updates will occur
#   every 15 seconds. A setting of zero disables redrawing at interval.
#
set-option -g status-interval 0


#   status-justify [left | centre | right]
#   Set the position of the window list component of the status line: left, centre
#   or right justified.
#
# positioning of the window list component specified above in the section:
# Window-Status Component
set-option -g status-justify centre

#   status-position [top | bottom]
#   Set the position of the status line.
#
set-option -g status-position top


#   status-style style
#   Set status line style. For how to specify style, see the STYLES section.
#
# for the general statusline, can be seen as the BaseClass for formatting the
# statusline
set-option -g status-style 'fg=colour225 bg=colour16'

# }}}


# the first line {{{

#   status-left string
#   Display string (by default the session name) to the left of the status line.
#   string will be passed through strftime(3). Also see the FORMATS and STYLES
#   sections.
#   For details on how the names and titles can be set see the NAMES AND TITLES section.
#
#   Examples are:
#
#   #(sysctl vm.loadavg)
#   #[fg=yellow,bold]#(apm -l)%%#[default] [#S]
    #
#   The default is ‘[#S] ’.
#
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


#   status-left-length length
#   Set the maximum length of the left component of the status line. The default is
#   10.
#
set -g status-left-length 40

#   status-left-style style
#   Set the style of the left part of the status line. For how to specify style,
#   see the STYLES section.
#



#   status-right string
#   Display string to the right of the status line. By default, the current pane
#   title in double quotes, the date and the time are shown. As with status-left,
#   string will be passed to strftime(3) and character pairs are replaced.
#
set -g status-right '\
Nº(#{?session_many_attached,#[fg=colour001],}#{session_attached}\
#[default],#{session_windows},#{window_panes})/\
∑(#{session_id},#{window_id},#{pane_id})\
'

#   status-right-length length
#   Set the maximum length of the right component of the status line. The default
#   is 40.
set -g status-right-length 40
#
#   status-right-style style
#   Set the style of the right part of the status line. For how to specify style,
#   see the STYLES section.
#

# }}}


# the second line {{{

#   status-format[] format
#   Specify the format to be used for each line of the status line. The default
#   builds the top status line from the various individual status options below.
#
# can be used to overwrite all further status-line settings
#       set-option -ug status-format[0]

# the second line of status-line
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
# the default setting for the second status-line
#       set-option -g status-format[1] "\
#[align=centre]#{P:#{?pane_active,#[reverse],}#{pane_index}\
[#{pane_width}x#{pane_height}]#[default] }\
"

# }}}

# }}}

# vim: filetype=tmux foldmethod=marker
