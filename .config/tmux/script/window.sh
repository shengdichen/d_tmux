#!/usr/bin/env dash

INDEX_MIN=1 # 1-indexing for windows

__n_windows() {
    tmux display-message -p -F "#{session_windows}"
}

__index_current() {
    tmux display-message -p -F "#{window_index}"
}

__switch_window() {
    tmux select-window -t ":=${1}."
}

# index calculation {{{
__index_rel_start() {
    local _idx
    _idx="$((INDEX_MIN + ${1}))"

    local _n_wins
    _n_wins="$(__n_windows)"
    if [ "${_idx}" -gt "${_n_wins}" ]; then
        _idx="${_n_wins}"
    fi
    printf "%d" "${_idx}"
}

__index_rel_end() {
    local _idx
    _idx="$(($(__n_windows) - ${1}))"

    if [ "${_idx}" -lt "${INDEX_MIN}" ]; then
        _idx="${INDEX_MIN}"
    fi
    printf "%d" "${_idx}"
}

__index_rel_current() {
    local _idx
    _idx="$(($(__index_current) + ${1}))"

    local _n_wins
    _n_wins="$(__n_windows)"
    if [ "${_idx}" -gt "${_n_wins}" ]; then
        _idx="${_n_wins}"
    elif [ "${_idx}" -lt "${INDEX_MIN}" ]; then
        _idx="${INDEX_MIN}"
    fi
    printf "%d" "${_idx}"
}
# }}}

main() {
    local _idx
    case "${1}" in
        "start")
            _idx="$(__index_rel_start "${2}")"
            ;;
        "end")
            _idx="$(__index_rel_end "${2}")"
            ;;
        "current")
            _idx="$(__index_rel_current "${2}")"
            ;;
    esac

    __switch_window "${_idx}"
}
main "${@}"
