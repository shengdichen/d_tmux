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

__pane_vifm_adapt_millerview() {
    local THRESHOLD=67

    local _target
    if [ "${1}" = "--target" ]; then
        _target="${1}"
        shift
    else
        _target="$(__make_target)"
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

__height_lhs_secondary_main() {
    local height_total height_primary
    height_total="$(__size_window --height)"
    height_primary="$(__squeeze $((height_total / 3)) 20 53)"

    printf "%d" $((height_total - height_primary))
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

__layout_horz() {
    local _equal=""
    if [ "${1}" = "--equal" ]; then
        _equal="yes"
    fi

    local _n_panes
    _n_panes="$(__n_panes_in_window)"
    if [ "${_n_panes}" -eq 1 ]; then
        return 0
    fi
    if [ "${_n_panes}" -eq 2 ]; then
        if [ "${_equal}" ]; then
            tmux select-layout even-vertical
        else
            __split_horz_submain
        fi
        __pane_vifm_adapt_millerview --target "$(__make_target --pane min)"
        return 0
    fi

    __split_horz_submain
    if [ "$(__pane_command --pane 1)" = "vifm" ]; then
        local _idx_pane_rhs_min
        if [ "$(__pane_command --pane 2)" = "zsh" ]; then
            _idx_pane_rhs_min=3
            __move_pane --from ":.2" --to ":.1" --size "$(__height_lhs_secondary_main)"
        else
            _idx_pane_rhs_min=2
        fi

        if [ "${_equal}" ]; then
            __resize_column_equal --min "${_idx_pane_rhs_min}"
        else
            __resize_column_emph --min "${_idx_pane_rhs_min}"
        fi
    fi

    __pane_vifm_adapt_millerview --target "$(__make_target --pane min)"
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
            __pane_vifm_adapt_millerview
            ;;
    esac
}
main "${@}"
unset -f main
