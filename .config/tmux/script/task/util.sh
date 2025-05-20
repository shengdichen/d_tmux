#!/usr/bin/env dash

# util {{{
__make_cmd_vifm() {
    __vifm() {
        printf -- "-c \"%s\"" "${1}"
    }

    __escape_path() {
        printf -- "\\\"%s\\\"" "${1}"
    }

    if [ "${#}" -eq 0 ]; then
        printf "vifm \"%s\" \"%s\"" "${HOME}" "${HOME}"
    elif [ "${#}" -eq 1 ]; then
        printf "vifm \"%s\" \"%s\"" "${1}" "${1}"
    elif [ "${#}" -eq 2 ]; then
        printf "vifm \"%s\" \"%s\"" "${1}" "${2}"
    else
        local _res="vifm" _is_first_tab="yes"
        local _is_first_tab="yes" _tabname=""
        local _path_1="" _path_2=""
        while [ "${#}" -gt 0 ]; do
            case "${1}" in
                "--tab")
                    shift
                    if [ "${_is_first_tab}" ]; then
                        _is_first_tab=""
                    else
                        _res="${_res} $(__vifm "tabnew")"
                    fi

                    if [ "${1}" = "--name" ]; then
                        _tabname="${2}"
                        shift 2
                    else
                        _tabname=""
                    fi

                    _path_1="$(__escape_path "${1}")"
                    _path_2="$(__escape_path "${2}")"
                    shift 2
                    _res="${_res} $(__vifm "cd ${_path_1} ${_path_2}")"

                    if [ "${_tabname}" ]; then
                        _res="${_res} $(__vifm "tabname ${_tabname}")"
                    fi
                    ;;
            esac
        done
        printf "%s" "${_res}"
    fi
}

__make_cmd_default() {
    __make_cmd_vifm
}

__make_cmd_poetry() {
    local _cd="" _cmd="${SHELL}"

    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--cd")
                _cd="${2}"
                shift && shift
                ;;
            "--cmd")
                _cmd="${2}"
                shift && shift
                ;;
        esac
    done

    local _res=""
    if [ "${_cd}" ]; then
        _res="${_res}cd \"${_cd}\" && "
    fi
    if [ "${_cmd}" ]; then
        _res="${_res}poetry run ${_cmd}"
    else
        _res="${_res}poetry shell"
    fi
    printf "%s" "${_res}"
}

__make_cmd_pwsh() {
    local _path="~" _command=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--path")
                _path="${2}"
                shift 2
                ;;
            "--command")
                _command="${2}"
                shift 2
                ;;
        esac
    done

    local _cmd="pwsh.exe"
    if [ "${_path}" ]; then
        _cmd="${_cmd} -WorkingDirectory \"${_path}\""
    fi
    if [ "${_command}" ]; then
        _cmd="${_cmd} -Command \"${_command}\""
    fi
    printf "%s\n" "${_cmd}"
}
# }}}

# session {{{
__has_session() {
    tmux has-session -t "=${1}" 2>/dev/null
}

__create_session() {
    local _name="ses" _window="main" _cd="${HOME}" _cmd=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--name")
                _name="${2}"
                shift && shift
                ;;
            "--window")
                _window="${2}"
                shift && shift
                ;;
            "--cd")
                _cd="${2}"
                shift && shift
                ;;
            "--cmd")
                _cmd="${2}"
                shift && shift
                ;;
        esac
    done

    if __has_session "${_name}"; then
        printf "tmux> session exists already, done! [%s]\n" "${_name}"
        return
    fi

    if [ ! "${_cmd}" ]; then
        _cmd="$(__make_cmd_default)"
    fi
    tmux new-session \
        -s "${_name}" \
        -n "${_window}" \
        -d \
        -c "${_cd}" \
        "${_cmd}"
}

__attach_session() {
    if ! __has_session "${1}"; then
        __create_session --name "${1}"
    fi
    tmux switch-client -t "${1}"
}
# }}}

# window {{{
__has_window() {
    local _session="."
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--session")
                _session="${2}"
                shift && shift
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    tmux list-windows -t "=${_session}" -F "#{window_name}" | grep -q "^${1}$"
}

__create_window() {
    local _session="" _pos="" _name="win" _allow_dup="" _cd="${HOME}" _cmd=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--session")
                _session="${2}"
                shift && shift
                ;;
            "--pos")
                _pos="${2}"
                shift && shift
                ;;
            "--name")
                _name="${2}"
                shift && shift
                ;;
            "--allow-dup")
                _allow_dup="yes"
                shift
                ;;
            "--cd")
                _cd="${2}"
                shift && shift
                ;;
            "--cmd")
                _cmd="${2}"
                shift && shift
                ;;
        esac
    done

    if __has_window --session "${_session}" -- "${_name}" && [ ! "${_allow_dup}" ]; then
        printf "tmux> window exists already, done! [%s]\n" "${_name}"
        return
    fi

    local _target _relative
    case "${_pos}" in
        "first")
            _target="=${_session}:^"
            _relative="-b"
            ;;
        "last")
            _target="=${_session}:$"
            _relative="-a"
            ;;
        "prev")
            _target="=${_session}:"
            _relative="-b"
            ;;
        "next")
            _target="=${_session}:"
            _relative="-a"
            ;;
        *)
            # insert after ${_pos}, defaulting to current window
            _target="=${_session}:${_pos}"
            _relative="-a"
            ;;
    esac

    if [ ! "${_cmd}" ]; then
        _cmd="$(__make_cmd_default)"
    fi
    tmux new-window \
        -t "${_target}" \
        "${_relative}" \
        -n "${_name}" \
        -d \
        -c "${_cd}" \
        "${_cmd}"
}
# }}}

# pane {{{
__new_pane() {
    local _target=":.+" _direction="-v" _cd="${HOME}" _cmd="${SHELL}"
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
            "--direction")
                case "${2}" in
                    "vert")
                        _direction="-v"
                        ;;
                    "horz")
                        _direction="-h"
                        ;;
                esac
                shift && shift
                ;;
            "--cd")
                _cd="${2}"
                shift && shift
                ;;
            "--cmd")
                _cmd="${2}"
                shift && shift
                ;;
        esac
    done

    tmux split-window \
        -t "${_target}" \
        "${_direction}" \
        -c "${_cd}" \
        "${_cmd}"
}

__send_key() {
    local _target=":." _wait=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
            "--wait")
                _wait="${2}"
                shift && shift
                ;;
            "--")
                shift && break
                ;;
        esac
    done

    if [ "${#}" -gt 0 ]; then
        tmux send-keys \
            -t "${_target}" \
            "${@}"
        if [ "${_wait}" ]; then
            sleep "${_wait}"
        fi
    fi
}

__vifm_tab_set() {
    local _target=":." _new="" _name="" _path_1="" _path_2=""
    while [ "${#}" -gt 0 ]; do
        case "${1}" in
            "--target")
                _target="${2}"
                shift && shift
                ;;
            "--new")
                _new="yes"
                shift
                ;;
            "--name")
                _name="${2}"
                shift && shift
                ;;
            "--path-1")
                _path_1="${2}"
                shift && shift
                ;;
            "--path-2")
                _path_2="${2}"
                shift && shift
                ;;
        esac
    done

    if [ "${_new}" ]; then
        __send_key --target "${_target}" -- ":tabnew" "Enter"
    fi

    if [ "${_path_1}" ]; then
        __send_key --target "${_target}" --wait 2 -- ":cd \"${_path_1}\"" "Enter"
    fi
    if [ "${_path_2}" ]; then
        __send_key --target "${_target}" -- "Space"
        __send_key --target "${_target}" --wait 2 -- ":cd \"${_path_2}\"" "Enter"
        __send_key --target "${_target}" -- "Space"
    fi
    if [ "${_name}" ]; then
        __send_key --target "${_target}" -- ":tabname ${_name}" "Enter"
    fi
}
# }}}

# vim: foldmethod=marker
