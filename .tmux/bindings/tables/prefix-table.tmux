# |prefix| key-table {{{

# client {{{
#   d       ->  Detach the current client.
bind-key -T prefix d detach-client

#   D       ->  Choose a client to detach.
bind-key -T prefix D choose-client -Z

#   r       ->  Force redraw of the attached client
# update the client
bind-key -T prefix r refresh-client

#   C-z     ->  Suspend the tmux client.
bind-key -T prefix C-z suspend-client

# }}}


# sessions {{{
# switching
#   L       ->  Switch the attached client back to the last session.
bind-key -T prefix L switch-client -l

#   (       ->  Switch the attached client to the previous session.
#   )       ->  Switch the attached client to the next session.
bind-key -T prefix ( switch-client -p
bind-key -T prefix ) switch-client -n

#   s       ->  Select a new session for the attached client interactively.
bind-key -T prefix s choose-tree -Zs -O "time"

# renaming
#   $       ->  Rename the current session
bind-key -T prefix "$" command-prompt -I "#S" "rename-session -- '%%'"

# }}}


# windows {{{
# creating
#   c       ->  Create a new window.
bind-key -T prefix c new-window

# switching
#   l       ->  Move to the previously selected window.
bind-key -T prefix l last-window

#   n       ->  Change to the next window.
bind-key -T prefix n next-window
#   p       ->  Change to the previous window.
bind-key -T prefix p previous-window

#   w       ->  Choose the current window interactively.
unbind-key -T prefix w
bind-key -T prefix w choose-tree -NZ -O "time"

#   '       ->  Prompt for a window index to select.
bind-key    -T prefix       "'"                   command-prompt -p index "select-window -t ':%%'"

#   0 to 9  ->  Select windows 0 to 9.
bind-key -T prefix 0 select-window -t :=0
bind-key -T prefix 1 select-window -t :=1
bind-key -T prefix 2 select-window -t :=2
bind-key -T prefix 3 select-window -t :=3
bind-key -T prefix 4 select-window -t :=4
bind-key -T prefix 5 select-window -t :=5
bind-key -T prefix 6 select-window -t :=6
bind-key -T prefix 7 select-window -t :=7
bind-key -T prefix 8 select-window -t :=8
bind-key -T prefix 9 select-window -t :=9

#   M-n     ->  Move to the next window with a bell or activity marker.
bind-key -T prefix M-n next-window -a
#   M-p     ->  Move to the previous window with a bell or activity marker.
bind-key -T prefix M-p previous-window -a


# renaming and killing
#   ,       ->  Rename the current window.
bind-key -T prefix , command-prompt -I "#W" "rename-window -- '%%'"
#   &       ->  Kill the current window.
bind-key -T prefix & confirm-before -p "Confirm Action: Window Termination" kill-window


# misc
#   .       ->  Prompt for an index to move the current window.
bind-key -T prefix . command-prompt "move-window -t '%%'"

#   f       ->  Prompt to search for text in open windows.
bind-key -T prefix f command-prompt "find-window -Z -- '%%'"

#   i       ->  Display some information about the current window.
bind-key -T prefix i display-message

# }}}


# panes {{{
# switching
#   ;       ->  Move to the previously active pane.
bind-key -T prefix ';' last-pane

#   o       ->  Select the next pane in the current window.
bind-key -T prefix o select-pane -t :.+

#   Up, Down, Left, Right
#           ->  Change to the pane above, below, to the left, or to the right
#               of the current pane.
bind-key -r -T prefix Up select-pane -U
bind-key -r -T prefix Down select-pane -D
bind-key -r -T prefix Left select-pane -L
bind-key -r -T prefix Right select-pane -R


# splitting and resizing
#   z       ->  Toggle zoom state of the current pane.
bind-key -T prefix z resize-pane -Z

#   "       ->  Split the current pane into two, top and bottom.
bind-key -T prefix '"' split-window
#   %       ->  Split the current pane into two, left and right.
bind-key -T prefix % split-window -h

#   C-Up, C-Down, C-Left, C-Right
#           ->  Resize the current pane in steps of one cell.
bind-key -r -T prefix C-Up resize-pane -U
bind-key -r -T prefix C-Down resize-pane -D
bind-key -r -T prefix C-Left resize-pane -L
bind-key -r -T prefix C-Right resize-pane -R

#   M-Up, M-Down, M-Left, M-Right
#           ->  Resize the current pane in steps of five cells.
bind-key -r -T prefix M-Up resize-pane -U 5
bind-key -r -T prefix M-Down resize-pane -D 5
bind-key -r -T prefix M-Left resize-pane -L 5
bind-key -r -T prefix M-Right resize-pane -R 5


# layout and resizing
#   M-1 to M-5
#           ->  Arrange panes in one of the five preset layouts:
#               even-horizontal, even-vertical, main-horizontal, main-vertical,
#               or tiled
bind-key -T prefix M-1 select-layout even-horizontal
bind-key -T prefix M-2 select-layout even-vertical
bind-key -T prefix M-3 select-layout main-horizontal
bind-key -T prefix M-4 select-layout main-vertical
bind-key -T prefix M-5 select-layout tiled

#   Space   ->  Arrange the current window in the next preset layout.
bind-key -T prefix Space next-layout

#   C-o     ->  Rotate the panes in the current window forwards.
# rotate all panes in the current window clockwise
bind-key -T prefix C-o rotate-window

#   M-o     -> Rotate the panes in the current window backwards.
# rotate all panes in the current window counter-clockwise
bind-key -T prefix M-o rotate-window -D

#   {       ->  Swap the current pane with the previous pane.
#   }       ->  Swap the current pane with the next pane.
bind-key -T prefix '{' swap-pane -U
bind-key -T prefix '}' swap-pane -D


# marking
#   m       ->  Mark the current pane (see select-pane -m).
bind-key -T prefix m select-pane -m

#   M       ->  Clear the marked pane.
bind-key -T prefix M select-pane -M


# misc
#   !       ->  Break the current pane out of the window.
bind-key -T prefix ! break-pane

#   x       ->  Kill the current pane.
bind-key -T prefix x confirm-before -p "CONFIRM Pane Termination" kill-pane

#   q       ->  Briefly display pane indexes.
bind-key -T prefix q display-panes

# }}}


# copy-mode {{{
#   [       ->  Enter copy mode to copy text or view the history.
#   ]       ->  Paste the most recently copied buffer of text.
bind-key -T prefix [ copy-mode
bind-key -T prefix ] paste-buffer

#   =       ->  Choose which buffer to paste interactively from a list.
bind-key -T prefix = choose-buffer -Z

#   -       ->  Delete the most recently copied buffer of text.
bind-key -T prefix - delete-buffer

#   PageUp  ->  Enter copy mode and scroll one page up.
bind-key -T prefix PPage copy-mode -u

#   #       ->  List all paste buffers.
bind-key -T prefix '#' list-buffers

# }}}


# misc {{{
#   ?       ->  List all key bindings.
bind-key -T prefix ? list-keys

#   t       ->  Show the time.
bind-key -T prefix t clock-mode

#   ~       ->  Show previous messages from tmux, if any.
bind-key -T prefix '~' show-messages

#   :       ->  Enter the tmux command prompt.
bind-key -T prefix : command-prompt

# }}}

# }}}

