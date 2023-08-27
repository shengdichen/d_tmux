# absolute window-number {{{
# SYNOPSIS:
#   obtain total number of windows in session
# CORE:
#   :run-shell "echo #{e|-:7,3} #{e|-:session_windows,1}"
getTotalNWindows() {
    total_windows=$(tmux run-shell "echo #{session_windows}")
    echo "$total_windows"
}

getCurrWindow() {
    curr_window=$(tmux run-shell "echo #{window_index}")
    echo "$curr_window"
}
# }}}

# relative window-number {{{
# SYNOPSIS:
#   obtain the relative window number from the first window
#
# TODO:
#   Do we need to care if positive index starts from 0 or 1?
getForwardsNumber() {
    first_window=1

    offset=$1
    ((target_window = first_window + offset))

    echo "$target_window"
}

# SYNOPSIS:
#   obtain the relative window number from the last window
#
# E.g.:
#   IN: 3
#   OUT: lastwindow-3
getBackwardsNumber() {
    total_windows=$(($(getTotalNWindows)))

    offset=$1
    ((target_window = total_windows - offset))

    echo "$target_window"
}

# SYNOPSIS:
#   obtain the window number relative to current
#
# SYNTAX:
#   IN: offset
#       ->  signed!
#
getRelativeWindowNumber() {
    curr_window=$(($(getCurrWindow)))
    offset=$1
    ((target_window = curr_window + offset))

    echo "$target_window"
}
# }}}

# attaching window {{{
# SYNOPSIS:
#   switch to given window number
attachWindows() {
    # if (absolute number, attach directly)
    #   else if (+x) attach
    #   else (-x), attach from end
    window_to_attach=$1
    tmux select-window -t "${window_to_attach}"
}
# }}}

# the big func {{{
# SYNTAX:
#   1.  argc != 1
#       ->  navigation relative to current window
#
#   2.  argc == 1
#       i.  argc[1] >= 1
#           ->  navigation relative to front
#       ii. argc[1] >= 1
#           ->  navigation relative to back
#
getNumber() {
    offset=$1

    if [[ "$#" -gt 1 ]]; then
        target=$(getRelativeWindowNumber "$offset")
    else
        if [[ $1 -ge 1 ]]; then
            target=$(getForwardsNumber "$1")
        else
            target=$(getBackwardsNumber $(($1 * -1)))
        fi
    fi

    echo "$target"
}

main() {
    window_to_attach=$(($(getNumber "$@")))
    attachWindows "$window_to_attach"
}

main "$@"
# }}}
