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
# non-default binds {{{
bind-key -r -T modTab M-Up resize-pane -U
bind-key -r -T modTab M-Down resize-pane -D
bind-key -r -T modTab M-Left resize-pane -L
bind-key -r -T modTab M-Right resize-pane -R

# stretching vertically {{{
bind-key -T modTab M-PPage resize-pane -y 50%
bind-key -T modTab M-NPage resize-pane -y 100%

bind-key -T modTab M-Home { \
    swap-pane -d -t :.2; \
    resize-pane -y 67% \
}
bind-key -T modTab M-End { \
    swap-pane -d -t :.2; \
    resize-pane -y 100% \
}
# }}}
# }}}
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

# non-default binds {{{
# -d to stay on the current pane after swapping
bind-key -T modTab M-H swap-pane -d -t :.'{left-of}'
bind-key -T modTab M-K swap-pane -d -t :.'{up-of}'
bind-key -T modTab M-J swap-pane -d -t :.'{down-of}'
bind-key -T modTab M-L swap-pane -d -t :.'{right-of}'
# }}}

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

#   non-default {{{
#       #   PageUp  ->  Enter copy mode and scroll one page up.
#       bind-key -T modTab M-PPage copy-mode -u
#   }}}

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

