# creation {{{
# NOTE:
#   -d: do not attach
#   -s: session-name
#   -n: window-name

new-session -s "sys" -n "admin" -d \
    "vifm ~/xdg/ ~/mnt/"
split-window -h -t "=sys:1." -d \
    -c "/"  # -c := cd
new-window -n "home" -t "=sys:2." -d \
    "vifm ~/ ~/Dots/"

new-session -s "ace" -n "data" -d \
    "vifm ~/xdg/ ~/mnt/x/Dox/"

new-session -s "ent" -n "ctrl" -d "\
    vifm ~/xdg/MDA/ ~/xdg/ \
        -c \"tabnew ~/xdg/MDA/Aud\" -c \"tabname Aud\" \
        -c \"tabnew ~/xdg/MDA/Vid\" -c \"tabname Vid\" \
        -c \"tabnew ~/xdg/MDA/Lit\" -c \"tabname Lit\" \
"
split-window -h -t "=ent:1." -d \
    "cmus"
split-window -v -t "=ent:1." -d \
    "pulsemixer"
new-window -n "MDA" -t "=ent:2." -d "\
    vifm ~/xdg/MDA/ ~/xdg/ \
        -c \"tabnew ~/xdg/MDA/Aud\" -c \"tabname Aud\" \
        -c \"tabnew ~/xdg/MDA/Vid\" -c \"tabname Vid\" \
        -c \"tabnew ~/xdg/MDA/Lit\" -c \"tabname Lit\" \
"

new-session -s "xyz" -n "misc" -d \
    "vifm ~/xdg/ ~/mnt/"
# }}}

# NOTE:
#   attach in reverse-order
attach-session -t "=xyz:1.1"
attach-session -t "=ent:1.1"
attach-session -t "=ace:1.1"
attach-session -t "=sys:1.2"

# vim: filetype=tmux foldmethod=marker
