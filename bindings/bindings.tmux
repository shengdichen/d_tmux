# setup {{{

# |prefix| key-table {{{

# C-b         Send the prefix key (C-b) through to the application.
# the key-binding to use to actually send the prefix, setting it to the prefix
# key itself equates to having to pressing the prefix twice to actually send it
# to the current application
bind-key    -T prefix       C-b                   send-prefix

# send the second prefix by pressing the same binding of |prefix2|
bind-key    -T prefix       M-Space               send-prefix -2

# }}}


# |defTab| key-table {{{

# set the default key-table to the customized key-table with less awkward
# prefixing
#       set-option -g key-table defTab

# remove all legacy bindings of the key-table |defTab| that might persist from
# previous experimentations
#       unbind-key -a -T defTab

# }}}


# |modTab| key-table {{{

# set the default key-table to the customized key-table with less awkward
# prefixing
set-option -g key-table modTab

# remove all legacy bindings of the key-table |defTab| that might persist from
# previous experimentations
unbind-key -a -T modTab

# }}}

# }}}



# bindings {{{

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


# |modTab| key-table {{{
# the modTab (MODified key-TABle) key-table is designed such that it:
#   1.  incorporates more intuitive keybinds for common commands available in
#       other contexts such as *Vim and Window Managers
#   2.  minimizes the keybinds to encourage direct manual input and
#       memorization of tmux-command instead of using keybinds themselves
#   3.  preserves the default tmux-bindings as long as the above points are not
#       violated
#
# in this spirit, modTab sees the most modifications in:
#   1.  cross-pane navigation
#           ->  hjkl-bindings
#   2.  quick switch
#           Alt-Tab!



# client {{{
#   d       ->  Detach the current client.
bind-key -T modTab M-d detach-client
#   D       ->  Choose a client to detach.
#       bind-key -T modTab M-D choose-client -Z

# update the client
#   r       ->  Force redraw of the attached client
#       bind-key -T modTab M-r refresh-client

#   C-z     ->  Suspend the tmux client.

# }}}


# sessions {{{
# switching
#   L       ->  Switch the attached client back to the last session.
#       bind-key -T modTab M-L switch-client -l
bind-key -T modTab M-Tab switch-client -l

#   (       ->  Switch the attached client to the previous session.
#   )       ->  Switch the attached client to the next session.
bind-key -T modTab M-( switch-client -p
bind-key -T modTab M-) switch-client -n

#   s       ->  Select a new session for the attached client interactively.
bind-key -T modTab M-s choose-tree -Zs -O "time"

# renaming
#   $       ->  Rename the current session
bind-key -T modTab M-'$' command-prompt -I "#S" "rename-session -- '%%'"

# }}}


# windows {{{
# creating
#   c       ->  Create a new window.
bind-key -T modTab M-c new-window

# switching
#   l       ->  Move to the previously selected window.
#   n       ->  Change to the next window.
#   p       ->  Change to the previous window.
#       bind-key -T modTab M-l last-window
bind-key -T modTab M-n next-window
bind-key -T modTab M-p previous-window
# non-default keybind
bind-key -T modTab M-` last-window

#   w       ->  Choose the current window interactively.
#   '       ->  Prompt for a window index to select.
bind-key -T modTab M-w choose-tree -NZ -O "time"
#       bind-key -T modTab M-"'" command-prompt -p index "select-window -t ':%%'"

#   0 to 9  ->  Select windows 0 to 9.
bind-key -T modTab M-0 select-window -t :=0.
bind-key -T modTab M-1 select-window -t :=1.
bind-key -T modTab M-2 select-window -t :=2.
bind-key -T modTab M-3 select-window -t :=3.
bind-key -T modTab M-4 select-window -t :=4.
bind-key -T modTab M-5 select-window -t :=5.
bind-key -T modTab M-6 select-window -t :=6.
bind-key -T modTab M-7 select-window -t :=7.
bind-key -T modTab M-8 select-window -t :=8.
bind-key -T modTab M-9 select-window -t :=9.

#   M-n     ->  Move to the next window with a bell or activity marker.
#   M-p     ->  Move to the previous window with a bell or activity marker.


# renaming and killing
#   ,       ->  Rename the current window.
bind-key -T modTab M-, command-prompt -I "#W" "rename-window -- '%%'"

#   &       ->  Kill the current window.
bind-key -T modTab M-& confirm-before -p "\
Confirm Action: Window Termination" kill-window


# misc
#   .       ->  Prompt for an index to move the current window.
#       bind-key -T modTab M-. command-prompt "move-window -t '%%'"

#   f       ->  Prompt to search for text in open windows.
#       bind-key -T modTab M-f command-prompt "find-window -Z -- '%%'"

#   i       ->  Display some information about the current window.
bind-key -T modTab M-i display-message



# non-default bindings {{{
# inner-session displacement of the current window
bind-key -T modTab M-N swap-window -d -t :+1.
bind-key -T modTab M-P swap-window -d -t :-1.
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
bind-key -T modTab M-';' last-pane
#   o       ->  Select the next pane in the current window.
bind-key -T modTab M-o select-pane -t :.+1

#   Up, Down, Left, Right
#           ->  Change to the pane above, below, to the left, or to the right
#               of the current pane.
#       bind-key -r -T modTab M-Up select-pane -U
#       bind-key -r -T modTab M-Down select-pane -D
#       bind-key -r -T modTab M-Left select-pane -L
#       bind-key -r -T modTab M-Right select-pane -R
bind-key -r -T modTab M-k select-pane -U
bind-key -r -T modTab M-j select-pane -D
bind-key -r -T modTab M-h select-pane -L
bind-key -r -T modTab M-l select-pane -R


# splitting and resizing
#   z       ->  Toggle zoom state of the current pane.
bind-key -T modTab M-z 'resize-pane -Z'

#   "       ->  Split the current pane into two, top and bottom.
bind-key -T modTab M-'"' split-window
#   %       ->  Split the current pane into two, left and right.
bind-key -T modTab M-% split-window -h

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
bind-key -T modTab M-Space next-layout

# rotate all panes in the current window
#   C-o     ->  Rotate the panes in the current window forwards.
# rotate all panes in the current window counterclockwise
#   M-o     ->  Rotate the panes in the current window backwards.

#   {       ->  Swap the current pane with the previous pane.
#   }       ->  Swap the current pane with the next pane.
bind-key -T modTab M-'{' swap-pane -U
bind-key -T modTab M-'}' swap-pane -D

# marking
#   m       ->  Mark the current pane (see select-pane -m).
bind-key -T modTab M-m select-pane -m
#   M       ->  Clear the marked pane.

# misc
#   !       ->  Break the current pane out of the window.
bind-key -T modTab M-! break-pane
#   x       ->  Kill the current pane.
bind-key -T modTab M-x confirm-before -p '\
CONFIRM Pane Termination' kill-pane

#   q       ->  Briefly display pane indexes.
bind-key -T modTab M-q display-panes

# "paste" the marked pane
# this can be thought of as the "cut-and-paste" version of split-window:
# instead of opening an empty split, join-pane opens a split and pasting in a
# specific pane. To avoid having to explicitly state the pane with
#       [-s <my_pane_to_paste>]
# mark the target pane beforehand and omit specifying the pane altogether,
# which will then use the marked pane as the source pane
#   -v/h    ->  opens a vertical or horizontal split
bind-key -T modTab M-M join-pane -v -t :.+
# }}}


# copy-mode {{{
#   [       ->  Enter copy mode to copy text or view the history.
bind-key -T modTab M-[ copy-mode

#   ]       ->  Paste the most recently copied buffer of text.
bind-key -T modTab M-] paste-buffer

#   =       ->  Choose which buffer to paste interactively from a list.
bind-key -T modTab M-= choose-buffer -Z

#   -       ->  Delete the most recently copied buffer of text.
bind-key -T modTab M-'-' delete-buffer

#   PageUp  ->  Enter copy mode and scroll one page up.
bind-key -T modTab M-PPage copy-mode -u

#   #       ->  List all paste buffers.
bind-key -T modTab M-'#' list-buffers

# }}}


# misc {{{
#   ?       ->  List all key bindings.
bind-key -T modTab M-'?' list-keys

#   t       ->  Show the time.
#       bind-key -T modTab M-t clock-mode

#   ~       ->  Show previous messages from tmux, if any.
#       bind-key -T modTab M-'~' show-messages

#   :       ->  Enter the tmux command prompt.
bind-key -T modTab M-':' command-prompt

# }}}


# non-default keybinds {{{
bind-key -T modTab M-e '\
source-file ~/.tmux.conf; \
display-message "[Configuration Reset]"; \
'

bind-key -T modTab M-E '\
source-file ~/.tmux/modes/focus.tmux; \
display-message "[Entered Focus Mode]"; \
'

# a much easier to hit shortcut for refreshing the client
bind-key -T modTab M-Enter refresh-client
# }}}

# }}}


# }}}

