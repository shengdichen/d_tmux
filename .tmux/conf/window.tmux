# NOTE:
#   1.  in startup script (loaded for starting tmux server)
#           do NOT put -u; otherwise tmux will complain upon server startup
#           about:
#               no current window
#   2.  in other config scripts (loaded after starting tmux server)
#           MUST have -u; otherwise the setting for the current window will NOT
#           be reset

set-option -gw pane-base-index 1
set-option -gw automatic-rename off

set-option -gw wrap-search on

set-option -gw monitor-activity on
set-option -gw monitor-bell on
set-option -gw monitor-silence 0  # do NOT monitor window-silence

# pane-info {{{
set-option -gw pane-border-status off

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

# the current pane
set-option -gw pane-active-border-style \
"bg=terminal fg=terminal"

# all other panes
set-option -gw pane-border-style \
"bg=colour008 fg=terminal"
# }}}

# misc {{{
set-option -gw mode-keys vi
set-option -gw mode-style \
"bg=terminal fg=terminal bold reverse"

set-option -gw clock-mode-colour colour008
set-option -gw clock-mode-style 12  # AM/PM
# }}}

# vim: filetype=tmux foldmethod=marker
