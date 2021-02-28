# pane styles {{{

#   window-active-style style
#   Set the pane style when it is the active pane. For how to specify style,
#   see the STYLES section.
#
# set style for the currently active pane
set-option -gw window-active-style '\
fg='#ede3f7' \
bg=colour016 \
'

#   window-style style
#   Set the pane style. For how to specify style, see the STYLES section.
# set style for all currently inactive panes
set-option -gw window-style '\
fg=colour239 \
bg=colour237 \
'

# }}}


#   allow-rename [on | off]
#   Allow programs in the pane to change the window name using a terminal
#   escape sequence (\ek...\e\\).
#
# don't rename windows automatically
set-option -gw allow-rename off


#   remain-on-exit [on | off]
#   A pane with this flag set is not destroyed when the program running in it
#   exits. The pane may be reactivated with the respawn-pane command.
#
# Do NOT automatically destroy a pane when its program exits, instead, allow
# respawning with |respawn-pane|.
# Kill a pane instead with |kill-pane| explicitly.
set-option -gw remain-on-exit on


#   alternate-screen [on | off]
#   This option configures whether programs running inside the pane may use the
#   terminal alternate screen feature, which allows the smcup and rmcup
#   terminfo(5) capabilities. The alternate screen feature preserves the
#   contents of the window when an interactive application starts and restores
#   it on exit, so that any output visible before the application starts
#   reappears unchanged after it exits.
#

