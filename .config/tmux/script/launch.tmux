start-server

# creation {{{
# session {{{
# NOTE:
#   -d: do not attach after creation
#   -s: name of session
#   -n: name of first-window
new-session -d -s "sys" -n "admin" \
    "vifm ~/xdg/ ~/mnt/"

new-session -d -s "ace" -n "data" \
    "vifm ~/xdg/ ~/mnt/x/Dox/"

new-session -d -s "ent" -n "ctrl" "\
    vifm ~/xdg/MDA/ ~/xdg/ \
        -c \"tabnew ~/xdg/MDA/Aud\" -c \"tabname Aud\" \
        -c \"tabnew ~/xdg/MDA/Vid\" -c \"tabname Vid\" \
        -c \"tabnew ~/xdg/MDA/Lit\" -c \"tabname Lit\" \
"

new-session -d -s "xyz" -n "misc" \
    "vifm ~/xdg/ ~/mnt/"
# }}}

# window {{{
# NOTE:
#   -d: do not attach after creation
new-window -d -n "home" -t "=sys:2." \
    "vifm ~/ ~/Dots/"

new-window -d -n "MDA" -t "=ent:2." "\
    vifm ~/xdg/MDA/ ~/xdg/ \
        -c \"tabnew ~/xdg/MDA/Aud\" -c \"tabname Aud\" \
        -c \"tabnew ~/xdg/MDA/Vid\" -c \"tabname Vid\" \
        -c \"tabnew ~/xdg/MDA/Lit\" -c \"tabname Lit\" \
"
# }}}

# pane {{{
split-window -d -t "=sys:1." -h -c "/"  # -c := cd
split-window -d -t "=ent:1." -h "cmus"
split-window -d -t "=ent:1." -v "pulsemixer"
# }}}
# }}}

# NOTE:
#   attach in reverse-order
attach-session -t "=xyz:1.1"
attach-session -t "=ent:1.1"
attach-session -t "=ace:1.1"
attach-session -t "=sys:1.2"

# manipulating the tmux-server outside of tmux {{{
#   $ tmux has-session
#   $ tmux kill-server

# attach
#   $ tmux attach-server -t "$<session_id>"
#   $ tmux attach-server -t <session_name>
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
# }}}

# vim: filetype=tmux foldmethod=marker
