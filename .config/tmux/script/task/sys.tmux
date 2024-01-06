new-session -s "sys" -n "setup" -d \
    "vifm ~/dot/setup/ ~/.config/tmux/script/"
split-window -h -t "=sys:1.1" -d

new-window -n "home" -t "=sys:2." \
    "vifm ~/dot/dot/d_prv/ ~/.password-store/"
split-window -h -t "=sys:2.1"
send-keys -t "=sys:2.2" \
    "man_sv free"

new-window -n "mnt" -t "=sys:3." \
    "vifm ~/mnt/ /run/media/"
split-window -h -t "=sys:3.1" -d \
    "top -d 1.3 -E G"
split-window -v -t "=sys:3.2" -d \
    "watch -n 1.3 free -h"
split-window -v -t "=sys:3.1" -d

# vim: filetype=tmux
