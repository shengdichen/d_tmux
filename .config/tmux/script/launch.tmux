# creation {{{
# NOTE:
#   -d: do not attach
#   -s: session-name
#   -n: window-name

new-session -s "sys" -n "home" -d \
    "vifm ~/dot/setup/ ~/.config/tmux/script/"
split-window -h -t "=sys:1.1" -d \
    "top -E G -d 1"
new-window -n "mnt" -t "=sys:2." -d \
    "vifm ~/mnt/ /run/media/"

new-session -s "mda" -n "ctrl" -d \
    "vifm ~/xdg/MDA/Aud/ ~/xdg/MDA/Vid/"
split-window -h -t "=mda:1.+" -d \
    "pulsemixer"
# }}}

# NOTE:
#   attach in reverse-order
attach-session -t "=mda:1.1"
attach-session -t "=sys:1.2"

# vim: filetype=tmux foldmethod=marker
