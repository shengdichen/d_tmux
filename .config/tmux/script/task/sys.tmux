new-session -s "sys" -n "home" -d \
    "vifm ~/dot/setup/ ~/.config/tmux/script/"
split-window -h -t "=sys:1.1" -d \
    "top -E G -d 1"

new-window -n "mnt" -t "=sys:2." -d \
    "vifm ~/mnt/ /run/media/"

# vim: filetype=tmux
