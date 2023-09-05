source-file ~/.tmux/modes/statusline/two_line.tmux



#   pane-border-status [off | top | bottom]
#   Turn pane border status lines off or set their position.
#
# use the pane-border status-line positioned at bottom of each pane instead of
# the default pane borders as pane border
set-option -u pane-border-status
set-option -gw pane-border-status bottom




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

# vim: filetype=tmux foldmethod=marker
