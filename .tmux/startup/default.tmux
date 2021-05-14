# default start-up procedure {{{
# 0.    start the server
start-server
# }}}

# manipulating the tmux-server outside of tmux {{{

# check if there is a server:
#     $ tmux has-session
# if: no server running on /tmp/tmux-1000/default


# start the server, this will implicitly source ~/.tmux.conf
#     $ tmux start-server
#     $ tmux -F ~/.tmux.conf start-server


# attach
# note: if run from outside of tmux and without a target, will attach to the
#       most recently active session, to attach to a specific session, use -t
#       with the target_argument delimited in single quotes if using $<ID>,
#       i.e.,
#     $ tmux attach-server -t '$<Session_ID>'
#       OR
#     $ tmux attach-server -t <Session_Name>



# kill the server
#       tmux kill-server

# }}}



# on the SERVER {{{

# 1. create the ubiquitous sessions
#       -s      name of the session
#       -n      name of the (only) window when first created
#       -A      attatch if the session to be created is already existing, instead
#               of throwing duplicate error
#       -d      create the session without attaching it, will only work if the
#               session to be created is not already existing, i.e., if already
#               existing, will attach to it anyway, use |switch-client|
#               afterwards to explicitly switch back to the previous session
#       -D      detach all other, if any, clients attached to this session
#   new-session -s "sys" -A -n "inst"; switch-client -l

# 1.1 create splits on the main window with, if any, layout

# 2. create every other window with, if any, splits and layout
#       -a      create the the window after the current window
#       -d      do NOT switch to the new window
#       -n      name of the window
#       -c      set the current working directory

# 3. switch to the main window


#       new-session -s "sys" -A -d -n "home" -c ~/; \
#       split-window -c ~/; last-pane; resize-pane -Z; \
#       new-window -a -c / -n "pacm"; \
#       select-window -l
#
#       new-session -s "xyz" -A -n "KlCt" -c /mnt/x/myData/KlCt/; \
#       new-window -a -d -c /mnt/x/myData/dev -n "dev"; \
#
#       new-session -s "acd" -A -d -n "data"; \
#       split-window -c /mnt/x/myData; last-pane
#
#       new-session -s "ent" -A -d -n "cmus" -c /mnt/x/myMusic/

# on SESSIONs {{{

# session reference [in order of precedence]:
#       a session ID
#       exact name of session
#       start of session name
#       pattern
#       create two windows

#   -t $<Session_ID>

# }}}


# on WINDOWs {{{

# window reference [in order of precedence]:
#       token
#       window index
#       window ID
#       exact window name
#       start of a window name
#       a pattern

#   -t $<Session_ID>:@<Window_ID>
#   -t :@<ID>

# }}}


# on PANEs {{{

# pane reference:
# given WINDOW reference, construct pane reference with:
#   -t $<Session_ID>:@<Window_ID>.<PANE_TOKEN>
#       OR
#   -t $<Session_ID>:@<Window_ID>.<PANE_NUMBER>
#       OR
#   -t $<Session_ID>:@<Window_ID>.<PANE_NUMBER>

# }}}
