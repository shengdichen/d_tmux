# |defTab| key-table {{{

# client {{{
#   d       ->  Detach the current client.
bind-key -T defTab M-d detach-client
#   D       ->  Choose a client to detach.
bind-key -T defTab M-D choose-client -Z

# update the client
#   r       ->  Force redraw of the attached client
bind-key -T defTab M-r refresh-client

#   C-z     ->  Suspend the tmux client.

# }}}


# sessions {{{
# switching
#   L       ->  Switch the attached client back to the last session.
bind-key -T defTab M-L switch-client -l

#   (       ->  Switch the attached client to the previous session.
#   )       ->  Switch the attached client to the next session.
bind-key -T defTab M-( switch-client -p
bind-key -T defTab M-) switch-client -n

#   s       ->  Select a new session for the attached client interactively.
bind-key -T defTab M-s choose-tree -Zs -O "time"

# renaming
#   $       ->  Rename the current session
bind-key -T defTab M-'$' command-prompt -I "#S" "rename-session -- '%%'"

# }}}


# windows {{{
# creating
#   c       ->  Create a new window.
bind-key -T defTab M-c new-window

# switching
#   l       ->  Move to the previously selected window.
#   n       ->  Change to the next window.
#   p       ->  Change to the previous window.
bind-key -T defTab M-l last-window
bind-key -T defTab M-n next-window
bind-key -T defTab M-p previous-window

#   w       ->  Choose the current window interactively.
#   '       ->  Prompt for a window index to select.
bind-key -T defTab M-w choose-tree -NZ -O "time"
bind-key -T defTab M-"'" command-prompt -p index "select-window -t ':%%'"

#   0 to 9  ->  Select windows 0 to 9.
bind-key -T defTab M-0 select-window -t :=0
bind-key -T defTab M-1 select-window -t :=1
bind-key -T defTab M-2 select-window -t :=2
bind-key -T defTab M-3 select-window -t :=3
bind-key -T defTab M-4 select-window -t :=4
bind-key -T defTab M-5 select-window -t :=5
bind-key -T defTab M-6 select-window -t :=6
bind-key -T defTab M-7 select-window -t :=7
bind-key -T defTab M-8 select-window -t :=8
bind-key -T defTab M-9 select-window -t :=9

#   M-n     ->  Move to the next window with a bell or activity marker.
#   M-p     ->  Move to the previous window with a bell or activity marker.


# renaming and killing
#   ,       ->  Rename the current window.
bind-key -T defTab M-, command-prompt -I "#W" "rename-window -- '%%'"

#   &       ->  Kill the current window.
bind-key -T defTab M-& confirm-before -p "\
Confirm Action: Window Termination" kill-window


# misc
#   .       ->  Prompt for an index to move the current window.
bind-key -T defTab M-. command-prompt "move-window -t '%%'"

#   f       ->  Prompt to search for text in open windows.
bind-key -T defTab M-f command-prompt "find-window -Z -- '%%'"

#   i       ->  Display some information about the current window.
bind-key -T defTab M-i display-message



# non-default bindings {{{
# inner-session displacement of the current window
bind-key -T defTab M-N swap-window -d -t :+1.
bind-key -T defTab M-P swap-window -d -t :-1.
# }}}

# cross-session displacement of the current window
#       move-window -t <my_session>:<window_number>
#
# create a copy of the current window (in any session)
#       link-window -t <my_session>:
# closing any copy of the window will close all copies of it, thus, undoing
# linking is required to close one particular copy
#       unlink-window -t <my_session>:<my_window>
# }}}


# panes {{{
# switching
#   ;       ->  Move to the previously active pane.
bind-key -T defTab M-';' last-pane
#   o       ->  Select the next pane in the current window.
bind-key -T defTab M-o select-pane -t :.+

#   Up, Down, Left, Right
#           ->  Change to the pane above, below, to the left, or to the right
#               of the current pane.
bind-key -r -T defTab M-Up select-pane -U
bind-key -r -T defTab M-Down select-pane -D
bind-key -r -T defTab M-Left select-pane -L
bind-key -r -T defTab M-Right select-pane -R


# splitting and resizing
#   z       ->  Toggle zoom state of the current pane.
bind-key -T defTab M-z 'resize-pane -Z'

#   "       ->  Split the current pane into two, top and bottom.
bind-key -T defTab M-'"' split-window
#   %       ->  Split the current pane into two, left and right.
bind-key -T defTab M-% split-window -h

#   C-Up, C-Down, C-Left, C-Right
#           ->  Resize the current pane in steps of one cell.
#   M-Up, M-Down, M-Left, M-Right
#           ->  Resize the current pane in steps of five cells.


# layout and resizing
#   M-1 to M-5
#           ->  Arrange panes in one of the five preset layouts:
#               even-horizontal, even-vertical, main-horizontal, main-vertical,
#               or tiled
#   Space   ->  Arrange the current window in the next preset layout.
bind-key -T defTab M-Space next-layout

# rotate all panes in the current window
#   C-o     ->  Rotate the panes in the current window forwards.
# rotate all panes in the current window counterclockwise
#   M-o     ->  Rotate the panes in the current window backwards.

#   {       ->  Swap the current pane with the previous pane.
#   }       ->  Swap the current pane with the next pane.
bind-key -T defTab M-'{' swap-pane -U
bind-key -T defTab M-'}' swap-pane -D

# marking
#   m       ->  Mark the current pane (see select-pane -m).
#   M       ->  Clear the marked pane.

# misc
#   !       ->  Break the current pane out of the window.
bind-key -T defTab M-! break-pane
#   x       ->  Kill the current pane.
bind-key -T defTab M-x confirm-before -p '\
CONFIRM Pane Termination' kill-pane

#   q       ->  Briefly display pane indexes.
bind-key -T defTab M-q display-panes

# }}}


# copy-mode {{{
#   [       ->  Enter copy mode to copy text or view the history.
bind-key -T defTab M-[ copy-mode

#   ]       ->  Paste the most recently copied buffer of text.
bind-key -T defTab M-] paste-buffer

#   =       ->  Choose which buffer to paste interactively from a list.
bind-key -T defTab M-= choose-buffer -Z

#   -       ->  Delete the most recently copied buffer of text.
bind-key -T defTab M-'-' delete-buffer

#   PageUp  ->  Enter copy mode and scroll one page up.
bind-key -T defTab M-PPage copy-mode -u

#   #       ->  List all paste buffers.
bind-key -T defTab M-'#' list-buffers

# }}}


# misc {{{
#   ?       ->  List all key bindings.
bind-key -T defTab M-'?' list-keys

#   t       ->  Show the time.
bind-key -T defTab M-t clock-mode

#   ~       ->  Show previous messages from tmux, if any.
bind-key -T defTab M-'~' show-messages

#   :       ->  Enter the tmux command prompt.
bind-key -T defTab M-':' command-prompt

# }}}


bind-key -T defTab M-e '\
source-file ~/.tmux.conf; \
display-message "[Configuration Reset]"; \
'

bind-key -T defTab M-E '\
source-file ~/.tmux/modes/focus.tmux; \
display-message "[Entered Focus Mode]"; \
'

# a much easier to hit shortcut for refreshing the client
bind-key -T defTab M-Enter refresh-client

# }}}

# vim: filetype=tmux foldmethod=marker
