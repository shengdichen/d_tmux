new-session -s "mda" -n "ctrl" -d \
    "vifm ~/xdg/MDA/Aud/ ~/xdg/MDA/Vid/"
split-window -h -t "=mda:1.+" -d \
    "pulsemixer"

# vim: filetype=tmux
