# NOTE:
#   1.  in startup script (loaded for starting tmux server)
#           do NOT put -u; otherwise tmux will complain upon server startup
#           about:
#               no current window
#   2.  in other config scripts (loaded after starting tmux server)
#           MUST have -u; otherwise the setting for the current window will NOT
#           be reset

set-option -g -w pane-base-index 1
set-option -g -w automatic-rename off

set-option -g -w wrap-search on

set-option -g -w monitor-activity on
set-option -g -w monitor-bell on
set-option -g -w monitor-silence 0  # do NOT monitor window-silence

# pane-info {{{
set-option -g -w pane-border-format ""

# LHS
set-option -g -w -a pane-border-format " "  # padding
set-option -g -w -a pane-border-format "\
#{pane_synchronized,#[fg=colour001][sync] ,}#[default]\
#{=/-19/#{l:/}.../:pane_current_path}/  >#{pane_current_command}\
"
set-option -g -w -a pane-border-format " "  # padding

# RHS
set-option -g -w -a pane-border-format "#[align=right]"
set-option -g -w -a pane-border-format "\
#{\
?pane_dead,\
#[reverse] [###{pane_index/#{window_panes}}]_EXIT@#{pane_dead_status} #[default],\
 [###{pane_index}/#{window_panes}#{?#{!=:#{pane_title},#{host}},#{pane_title},}] \
}\
"

# the current pane
set-option -g -w pane-active-border-style \
"bg=terminal fg=colour007"

# all other panes
set-option -g -w pane-border-style \
"bg=colour008 fg=colour007"
# }}}

# misc {{{
set-option -g -w aggressive-resize on

set-option -g -w mode-keys vi
set-option -g -w mode-style \
"bg=terminal fg=terminal bold reverse"

set-option -g -w clock-mode-colour colour008
set-option -g -w clock-mode-style 12  # AM/PM
# }}}

# vim: filetype=tmux foldmethod=marker
