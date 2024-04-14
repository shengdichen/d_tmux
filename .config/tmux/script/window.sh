#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

. "./util.sh"

__index_rel_start() {
    local _idx
    _idx="$((IDX_WINDOW_MIN + ${1}))"

    local _n_wins
    _n_wins="$(__n_windows_in_session)"
    if [ "${_idx}" -gt "${_n_wins}" ]; then
        _idx="${_n_wins}"
    fi
    printf "%d" "${_idx}"
}

__index_rel_end() {
    local _idx
    _idx="$(($(__n_windows_in_session) - ${1}))"

    if [ "${_idx}" -lt "${IDX_WINDOW_MIN}" ]; then
        _idx="${IDX_WINDOW_MIN}"
    fi
    printf "%d" "${_idx}"
}

__index_rel_current() {
    local _idx
    _idx="$(($(__get_prop -- "window_index") + ${1}))"

    local _n_wins
    _n_wins="$(__n_windows_in_session)"
    if [ "${_idx}" -gt "${_n_wins}" ]; then
        _idx="${_n_wins}"
    elif [ "${_idx}" -lt "${IDX_WINDOW_MIN}" ]; then
        _idx="${IDX_WINDOW_MIN}"
    fi
    printf "%d" "${_idx}"
}

__main() {
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

    tmux select-window -t ":=${_idx}."
}
__main "${@}"
