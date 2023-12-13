# NOTE:
#   -d: do not attach
#   -s: session-name
#   -n: window-name

source-file "~/.config/tmux/script/task/sys.tmux"
source-file "~/.config/tmux/script/task/mda.tmux"

attach-session -t "=sys:1.2"

# vim: filetype=tmux foldmethod=marker
