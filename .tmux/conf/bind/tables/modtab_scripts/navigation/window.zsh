function n_windows() {
    echo $(tmux display-message -p -F "#{session_windows}")
}

function index_current() {
    echo $(tmux display-message -p -F "#{window_index}")
}

function switch_window() {
    tmux select-window -t ":=$1."
}

# index calculation {{{
function index_rel_start() {
    local target="$((1 + $1))"  # 1-indexing for windows

    echo "${target}"
}

function index_rel_end() {
    local target="$(("$(n_windows)" - $1))"

    echo "${target}"
}

function index_rel_current() {
    local target="$(("$(index_current)" + $1))"

    echo "${target}"
}
# }}}


function main() {
    case $1 in
        "start")
            index=$(index_rel_start "$2")
            ;;
        "end")
            index=$(index_rel_end "$2")
            ;;
        "current")
            index=$(index_rel_current "$2")
            ;;
    esac

    switch_window "${index}"

    unfunction n_windows index_current switch_window index_rel_start index_rel_end index_rel_current
}
main "$@"
unfunction main
