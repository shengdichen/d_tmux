# NOTE:
#   1.  in startup script (loaded for starting tmux server)
#           do NOT put -u; otherwise tmux will complain upon server startup
#           about:
#               no current window
#   2.  in other config scripts (loaded after starting tmux server)
#           MUST have -u; otherwise the setting for the current window will NOT
#           be reset


# renaming and indexing {{{

#   pane-base-index index
#   Like base-index, but set the starting index for pane numbers.
#
# use 1-indexing whenever a new pane is created, similar to |base-index|
set-option -gw pane-base-index 1


#   automatic-rename [on | off]
#   Control automatic window renaming. When this setting is enabled, tmux will
#   rename the window automatically using the format specified by
#   automatic-rename-format. This flag is automatically disabled for an individual
#   window when a name is specified at creation with new-window or new-session, or
#   later with rename-window, or with a terminal escape sequence. It may be
#   switched off globally with: set-option -wg automatic-rename off
#
set-option -gw automatic-rename off

#   automatic-rename-format format
#   The format (see FORMATS) used when the automatic-rename option is enabled.
#

# }}}


# notification {{{

#   monitor-activity [on | off]
#   Monitor for activity in the window. Windows with activity are highlighted in
#   the status line.
#
# trigger response if a window has an activity, i.e., if ANYTHING displayed has
# been changed
set-option -gw monitor-activity on

#   monitor-bell [on | off]
#   Monitor for a bell in the window. Windows with a bell are highlighted in the
#   status line.
#
# trigger response if a window experiences bell
set-option -gw monitor-bell on

#   monitor-silence [interval]
#   Monitor for silence (no activity) in the window within interval seconds.
#   Windows that have been silent for the interval are highlighted in the status
#   line. An interval of zero disables the monitoring.
#
# trigger responce in status-line if window has been silent for 0 seconds,
# i.e., do not monitor if the current window is silent
set-option -gw monitor-silence 0

# }}}


# mode-keys {{{

#   mode-keys [vi | emacs]
#   Use vi or emacs-style key bindings in copy mode. The default is emacs, unless
#   VISUAL or EDITOR contains ‘vi’.
#
# use vi keybindings in copy-mode
set-option -gw mode-keys vi

#   mode-style style
#   Set window modes style. For how to specify style, see the STYLES section.
#
# set the monochrome style for all alternative modes, e.g., copy-mode,
# select-mode
set-option -gw mode-style '\
fg=colour015 \
bg=colour237 \
bold \
'

# }}}


# clock-mode {{{

#   clock-mode-colour colour
#   Set clock colour.
#
# set the colour of the color envoked by |clock-mode|
set-option -gw clock-mode-colour colour008

#   clock-mode-style [12 | 24]
#   Set clock hour format.
#
# use AM/PM for time display
set-option -gw clock-mode-style 12

# }}}



# pane-sizing {{{

#   aggressive-resize [on | off]
#   Aggressively resize the chosen window. This means that tmux will resize the
#   window to the size of the smallest or largest session (see the window-size
#   option) for which it is the current window, rather than the session to
#   which it is attached. The window may resize when the current window is
#   changed on another session; this option is good for full-screen programs
#   which support SIGWINCH and poor for interactive programs such as shells.
#

#   window-size largest | smallest | manual
#   Configure how tmux determines the window size. If set to largest, the size of
#   the largest attached session is used; if smallest, the size of the smallest. If
#   manual, the size of a new window is set from the default-size option and
#   windows are resized automatically. See also the resize-window command and the
#   aggressive-resize option.
#


#   main-pane-height height
#

#   main-pane-width width
#   Set the width or height of the main (left or top) pane in the main-horizontal
#   or main-vertical layouts.
#

#   other-pane-height height
#   Set the height of the other panes (not the main pane) in the main-horizontal
#   layout. If this option is set to 0 (the default), it will have no effect. If
#   both the main-pane-height and other-pane-height options are set, the main pane
#   will grow taller to make the other panes the specified height, but will never
#   shrink to do so.
#

#   other-pane-width width
#   Like other-pane-height, but set the width of other panes in the main-vertical
#   layout.
#

# }}}


# pane-border {{{

#   pane-border-status [off | top | bottom]
#   Turn pane border status lines off or set their position.
#
# use the pane-border status-line positioned at bottom of each pane instead of
# the default pane borders as pane border
#       set-option -gw pane-border-status bottom
#
# OR, switch off the pane-border
set-option -gw pane-border-status off
#

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



#   wrap-search [on | off]
#   If this option is set, searches will wrap around the end of the pane contents.
#   The default is on.
#
# wrap searches around once the end of the pane has been reached
set-option -gw wrap-search on


#   synchronize-panes [on | off]
#   Duplicate input to any pane to all other panes in the same window (only for
#   panes that are not in any special mode).
#


#   xterm-keys [on | off]
#   If this option is set, tmux will generate xterm(1) -style function key
#   sequences; these have a number included to indicate modifiers such as Shift,
#   Alt or Ctrl.
#

