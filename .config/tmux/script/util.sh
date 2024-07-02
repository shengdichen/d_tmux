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
                _window="${2}"
                shift && shift
                ;;
            "--pane")
                _pane="${2}"
                shift && shift
                ;;
        esac
    done
    case "${_window}" in
        "min")
            _window="${IDX_WINDOW_MIN}"
            ;;
        "max")
            _window="$(__n_windows_in_session --session "${_session}")"
            ;;
    esac
    case "${_pane}" in
        "min")
            _pane="${IDX_PANE_MIN}"
            ;;
        "max")
            _pane="$(__n_panes_in_window --window "${_session}:${_window}")"
            ;;
    esac

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
                _target="$(__make_target --pane "${2}")"
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

__is_pane_command() {
    local _target=":."
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--pane")
                _target="$(__make_target --pane "${2}")"
                shift && shift
                ;;
            "--target")
                _target="${2}"
                shift && shift
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    [ "$(__pane_command --target "${_target}")" = "${1}" ]
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
# }}}

# vim: foldmethod=marker
