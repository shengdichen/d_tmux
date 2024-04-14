#!/usr/bin/env dash

IDX_WINDOW_MIN=1
IDX_PANE_MIN=1

# generic {{{
__get_prop() {
    local _target="" _prop=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
            "--")
                _prop="${2}"
                shift && shift && break
                ;;
            *) exit 3 ;;
        esac
    done

    tmux display-message \
        -p \
        -t "${_target}" \
        -F "#{${_prop}}"
}

__n_windows_in_session() {
    local _session=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--session")
                _session="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_session}" -- "session_windows"
}

__n_panes_in_window() {
    local _window=":"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--window")
                _window="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_window}" -- "window_panes"
}

__make_target() {
    local _session="" _window="" _pane=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--session")
                _session="${2}"
                shift && shift
                ;;
            "--window")
                shift
                if [ "${1}" = "min" ]; then
                    _window="${IDX_WINDOW_MIN}"
                else
                    _window="${1}"
                fi
                shift
                ;;
            "--pane")
                shift
                if [ "${1}" = "min" ]; then
                    _pane="${IDX_PANE_MIN}"
                else
                    _pane="${1}"
                fi
                shift
                ;;
        esac
    done
    if [ "${_window}" = "max" ]; then
        _window="$(__n_windows_in_session --session "${_session}")"
    fi
    if [ "${_pane}" = "max" ]; then
        _pane="$(__n_panes_in_window --window "${_session}:${_window}")"
    fi

    printf "%s:%s.%s" "${_session}" "${_window}" "${_pane}"
}
# }}}

# window {{{
__index_window() {
    local _target=":"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_target}" -- "window_index"
}

__size_window() {
    local _direction="width" _target=":"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--width")
                _direction="width"
                shift
                ;;
            "--height")
                _direction="height"
                shift
                ;;
            "--target")
                _target="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_target}" -- "window_${_direction}"
}
# }}}

# pane {{{
__pane_command() {
    local _target=":."
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--pane")
                _target=":.${2}"
                shift && shift
                ;;
            "--target")
                _target="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_target}" -- "pane_current_command"
}

__index_pane() {
    local _target=":."
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_target}" -- "pane_index"
}

__size_pane() {
    local _direction="width" _target=":."
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--width")
                _direction="width"
                shift
                ;;
            "--height")
                _direction="height"
                shift
                ;;
            "--target")
                _target="${2}"
                shift && shift
                ;;
        esac
    done

    __get_prop --target "${_target}" -- "pane_${_direction}"
}

__move_pane() {
    local _target_from=":." _target_to=":.-" _size="" _direction="-v"

    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--from")
                _target_from="${2}"
                shift && shift
                ;;
            "--to")
                _target_to="${2}"
                shift && shift
                ;;
            "--horz")
                _direction="-h"
                shift
                ;;
            "--vert")
                _direction="-v"
                shift
                ;;
            "--size")
                _size="${2}" # size after moving
                shift && shift
                ;;
        esac
    done

    # -d := do NOT switch to source-pane
    tmux join-pane \
        -d \
        "${_direction}" \
        -s "${_target_from}" \
        -t "${_target_to}" \
        -l "${_size}"
}

__create_pane() {
    local _target=":."
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
        esac
    done
    tmux split-window \
        -t "${_target}"
}

__resize_pane() {
    local _target=":." _width="" _height=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
            "--width")
                _width="${2}"
                shift && shift
                ;;
            "--height")
                _height="${2}"
                shift && shift
                ;;
        esac
    done

    if [ "${_width}" ] && [ "${_height}" ]; then
        tmux resize-pane -t "${_target}" -x "${_width}" -y "${_height}"
    elif [ "${_width}" ]; then
        tmux resize-pane -t "${_target}" -x "${_width}"
    elif [ "${_height}" ]; then
        tmux resize-pane -t "${_target}" -y "${_height}"
    else
        true # noop
    fi
}

__resize_column_equal() {
    local _idx_min="" _idx_max="" _height_all="100"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--min")
                _idx_min="${2}"
                shift && shift
                ;;
            "--max")
                _idx_max="${2}"
                shift && shift
                ;;
            "--height-all")
                _height_all="${2}"
                shift && shift
                ;;
        esac
    done
    if [ ! "${_idx_min}" ]; then
        _idx_min="${IDX_PANE_MIN}"
    fi
    if [ ! "${_idx_max}" ]; then
        _idx_max="$(__n_panes_in_window)"
    fi
    if [ "${_idx_min}" -ge "${_idx_max}" ]; then
        return 0
    fi

    local _n_panes _height_nonlast _height_last
    _n_panes="$((_idx_max - _idx_min + 1))"
    _height_nonlast="$((_height_all / _n_panes))"
    _height_last="$((_height_all - (_n_panes - 1) * _height_nonlast))"

    for _idx in $(seq "${_idx_min}" "$((_idx_max - 1))"); do
        __resize_pane --target ":.${_idx}" --height "${_height_nonlast}%"
    done
    __resize_pane --target ":.${_idx_max}" --height "${_height_last}%"
}

__resize_column_emph() {
    local _idx_min="" _idx_max="" _height_all="100" _height_emph="67"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--min")
                _idx_min="${2}"
                shift && shift
                ;;
            "--max")
                _idx_max="${2}"
                shift && shift
                ;;
            "--height-all")
                _height_all="${2}"
                shift && shift
                ;;
            "--height-emph")
                _height_emph="${2}"
                shift && shift
                ;;
        esac
    done
    if [ ! "${_idx_min}" ]; then
        _idx_min="${IDX_PANE_MIN}"
    fi
    if [ ! "${_idx_max}" ]; then
        _idx_max="$(__n_panes_in_window)"
    fi
    if [ "${_idx_min}" -ge "${_idx_max}" ]; then
        return 0
    fi

    __resize_pane --target ":.${_idx_min}" --height "${_height_emph}%"
    __resize_column_equal \
        --min "$((_idx_min + 1))" \
        --max "${_idx_max}" \
        --height-all "$((_height_all - _height_emph))"
}
# }}}

# vim: foldmethod=marker
