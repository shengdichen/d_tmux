# creation {{{
# NOTE:
#   -d: do not attach
#   -s: session-name
#   -n: window-name

new-session -d -s "sys" -n "admin" \
    "vifm ~/xdg/ ~/mnt/"
split-window -d -t "=sys:1." -h \
    -c "/"  # -c := cd
new-window -d -n "home" -t "=sys:2." \
    "vifm ~/ ~/Dots/"

new-session -d -s "ace" -n "data" \
    "vifm ~/xdg/ ~/mnt/x/Dox/"

new-session -d -s "ent" -n "ctrl" "\
    vifm ~/xdg/MDA/ ~/xdg/ \
        -c \"tabnew ~/xdg/MDA/Aud\" -c \"tabname Aud\" \
        -c \"tabnew ~/xdg/MDA/Vid\" -c \"tabname Vid\" \
        -c \"tabnew ~/xdg/MDA/Lit\" -c \"tabname Lit\" \
"
split-window -d -t "=ent:1." -h \
    "cmus"
split-window -d -t "=ent:1." -v \
    "pulsemixer"
new-window -d -n "MDA" -t "=ent:2." "\
    vifm ~/xdg/MDA/ ~/xdg/ \
        -c \"tabnew ~/xdg/MDA/Aud\" -c \"tabname Aud\" \
        -c \"tabnew ~/xdg/MDA/Vid\" -c \"tabname Vid\" \
        -c \"tabnew ~/xdg/MDA/Lit\" -c \"tabname Lit\" \
"

new-session -d -s "xyz" -n "misc" \
    "vifm ~/xdg/ ~/mnt/"
# }}}

# NOTE:
#   attach in reverse-order
attach-session -t "=xyz:1.1"
attach-session -t "=ent:1.1"
attach-session -t "=ace:1.1"
attach-session -t "=sys:1.2"

# vim: filetype=tmux foldmethod=marker
