#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

. "./util.sh"

__squeeze() {
    local _val="${1}" _min="${2}" _max="${3}"
    if [ "${_val}" -lt "${_min}" ]; then
        printf "%d" "${_min}"
    elif [ "${_val}" -gt "${_max}" ]; then
        printf "%d" "${_max}"
    else
        printf "%d" "${_val}"
    fi
}

__split_horz_submain() {
    tmux select-layout main-vertical

    local WIDTH_MIN=59 WIDTH_MAX=97
    local _width
    _width="$(__squeeze "$(($(__size_window --width) / 3))" "${WIDTH_MIN}" "${WIDTH_MAX}")"
    __resize_pane \
        --target "$(__make_target --pane min)" \
        --width "${_width}"
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

__resize_column_lhs() {
    local _height_all _height_vifm HEIGHT_VIFM_MIN=20 HEIGHT_VIFM_MAX=53
    _height_all="$(__size_window --height)"
    _height_vifm="$(
        __squeeze "$((_height_all / 3))" "${HEIGHT_VIFM_MIN}" "${HEIGHT_VIFM_MAX}"
    )"

    __move_pane \
        --from ":.$((IDX_PANE_MIN + 1))" \
        --to ":.${IDX_PANE_MIN}" \
        --size "$((_height_all - _height_vifm))"
}

__pane_vifm_adapt_millerview() {
    local THRESHOLD=67

    local _target
    if [ "${1}" = "--target" ]; then
        shift
        if [ "${1}" = "this" ]; then
            _target="$(__make_target)"
        else
            _target="${1}"
        fi
        shift
    else
        _target="$(__make_target --pane min)" # vifm as first pane by default
    fi

    if [ "$(__pane_command --target "${_target}")" = "vifm" ]; then
        local _width
        _width="$(__size_pane --target "${_target}" --width)"

        if [ "${_width}" -lt "${THRESHOLD}" ]; then
            tmux send-keys -t "${_target}" ":set nomillerview" "Enter"
        else
            tmux send-keys -t "${_target}" ":set millerview" "Enter"
        fi
    fi
}

__layout_horz() {
    local _equal=""
    if [ "${1}" = "--equal" ]; then
        shift
        _equal="yes"
    fi

    local _n_panes
    _n_panes="$(__n_panes_in_window)"
    if [ "${_n_panes}" -eq 1 ]; then return 0; fi
    if [ "${_n_panes}" -eq 2 ]; then
        if [ "${_equal}" ]; then
            tmux select-layout even-vertical
        else
            __split_horz_submain
        fi
        __pane_vifm_adapt_millerview
        return 0
    fi

    __split_horz_submain
    if __is_pane_command --pane min -- "vifm"; then
        local _idx_pane_rhs_min
        if __is_pane_command --pane 2 -- "zsh"; then
            _idx_pane_rhs_min=3
            __resize_column_lhs
        else
            _idx_pane_rhs_min=2
        fi

        if [ "${_equal}" ]; then
            __resize_column_equal --min "${_idx_pane_rhs_min}"
        else
            __resize_column_emph --min "${_idx_pane_rhs_min}"
        fi

        __pane_vifm_adapt_millerview
    fi
}

main() {
    case "${1}" in
        "vert_main")
            __layout_horz
            ;;
        "vert_even")
            __layout_horz --equal
            ;;
        "vifm_miller")
            shift
            __pane_vifm_adapt_millerview --target this
            ;;
    esac
}
main "${@}"
unset -f main
