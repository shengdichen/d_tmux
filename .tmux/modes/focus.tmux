source-file ~/.tmux/modes/statusline/nil_line.tmux




#   pane-border-status [off | top | bottom]
#   Turn pane border status lines off or set their position.
#
# use the pane-border status-line positioned at bottom of each pane instead of
# the default pane borders as pane border
#       set-option -gw pane-border-status bottom
#
#
# OR: disable the pane-border status-line completely
set-option -u pane-border-status

set-option -gw pane-border-status off


# pane-border {{{

#   pane-border-status [off | top | bottom]
#   Turn pane border status lines off or set their position.
#
# use the pane-border status-line positioned at bottom of each pane instead of
# the default pane borders as pane border
#       set-option -gw pane-border-status bottom
set-option -u pane-border-status
set-option -gw pane-border-status off

#   pane-border-format format
#   Set the text shown in pane border status lines.
#
# the default
# set-option -gw pane-border-format '\
#{?pane_active,#[reverse],}#{pane_index}#[default] \
#{pane_title}'
#
set-option -gw pane-border-format ' \
#{\
?pane_dead,\
#[fg=colour001 bg=colour007 bold][###{pane_index}]_EXIT@#{pane_dead_status},\
[###{pane_index}>#{pane_tty}]_#{pane_title}\
}\
#[default] \
\
#[align=right] \
#{pane_synchronized,#[fg=colour001][sync] ,}#[default]\
#{host}:#{=/-19/#{l:/}.../:pane_current_path}/ \
~> #{pane_current_command} \
'

#   pane-active-border-style style
#   Set the pane border style for the currently active pane. For how to specify
#   style, see the STYLES section. Attributes are ignored.
#
# style of the border of the currently active pane
set-option -gw pane-active-border-style '\
fg=colour255 \
bg=colour016 \
bold \
'

#   pane-border-style style
#   Set the pane border style for panes aside from the active pane. For how to
#   specify style, see the STYLES section. Attributes are ignored.
#
# style of the border of all currently inactive pane(s)
set-option -gw pane-border-style '\
fg=colour242 \
bg=colour016 \
'

# }}}



# generally, i.e., only current pane visible
#       ->  in focus mode, i.e., no tmux-info
#
# when navigating by pressing C-z
#       ->  display comprehensive info, i.e., info-mode
#
#
# general procedure of focus-mode:
#       0.  unset
#           set-option -u <config>
#
#       1.  set to value
#
# status-line:
#   0 line:
#       set -g status off
#
#   1 line:
#       0.  set -g status on
#       1.  components of the 1st (and the only) row
#           a.  center component: activate window components
#               1.  separator -> |
#               2.  component of each window: enable
#               3.  put this in the center
#           b.  left and right components:
#               1.  left: set to null
#               2.  right: set to null
#
#       2.  components of the 2nd row:
#           leave unchanged, will simply not be visible now
#
#
#   2 lines:
#       0.  set -g status 2
#       1.  components of the 1st row
#           a.  center component: deactivate window components:
#               1.  separator -> nil
#               2.  component of each window: disable
#               3.  still kept in the center, which is trivial now
#           b.  left and right components:
#               1.  left: show pts, keytable
#               2.  right: show numbering of clients. sessions and windows
#
#       2.  components of the 2nd row
#               set components to simulate window components

