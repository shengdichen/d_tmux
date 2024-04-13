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

set_vifm_miller() {
    local _target="" _threshold=67
    if [ "${#}" -gt 0 ]; then
        _target="$(__make_target --pane "${1}")"
    else
        _target="$(__make_target)"
    fi

    if [ "$(__get_prop_pane_command --target "${_target}")" = "vifm" ]; then
        local _width
        _width="$(__size_pane --target "${_target}" --width)"

        if [ "${_width}" -lt "${_threshold}" ]; then
            tmux send-keys -t "${_target}" ":set nomillerview" "Enter"
        else
            tmux send-keys -t "${_target}" ":set millerview" "Enter"
        fi
    fi
}

height_lhs_secondary_main() {
    local height_total height_primary
    height_total="$(__size_window --height)"
    height_primary="$(__squeeze $((height_total / 3)) 20 53)"

    printf "%d" $((height_total - height_primary))
}

__layout_horz_main() {
    tmux select-layout main-vertical

    local _width_min=59 _width_max=97
    local _width
    _width="$(__squeeze "$(($(__size_window --width) / 3))" "${_width_min}" "${_width_max}")"
    tmux resize-pane -t ":.1" -x "${_width}"
}

move_to_split() {
    local source="${1}" to_split="${2}" new_size="${3}"

    # -d := do NOT switch to source-pane
    tmux join-pane \
        -d \
        -s "${source}" \
        -t "${to_split}" \
        -l "${new_size}"
}

even_vertical() {
    local start="${1}" end="${2}" full_size="${3}"

    if [ "${start}" -lt "${end}" ]; then
        local n_panes size_avg size_last
        n_panes="$((end - start + 1))"
        size_avg="$((full_size / n_panes))"
        size_last="$((full_size - (n_panes - 1) * size_avg))"

        for pane in $(seq "${start}" $((end - 1))); do
            tmux resize-pane -t ":.${pane}" -y "${size_avg}%"
        done
        tmux resize-pane -t ":.${end}" -y "${size_last}%"
    fi
}

main_vertical() {
    local start="${1}" end="${2}" main_size="${3}"

    if [ "${start}" -lt "${end}" ]; then
        tmux resize-pane -t ":.${start}" -y "${main_size}%"
        even_vertical $((start + 1)) "${end}" $((100 - main_size))
    fi
}

pipeline() {
    local mode="${1}"

    local _n_panes
    _n_panes="$(__n_panes_in_window)"

    if [ "${_n_panes}" -eq 2 ]; then
        tmux resize-pane -t ":.1" -x "50%"
        case "${mode}" in
            "vert_even")
                tmux select-layout even-vertical
                ;;
            "vert_main")
                __layout_horz_main
                ;;
        esac
    elif [ "$(__get_prop_pane_command --pane 1)" = "vifm" ]; then
        __layout_horz_main
        local idx_rhs_start=2
        if [ "$(__get_prop_pane_command --pane 2)" = "zsh" ]; then
            idx_rhs_start=3
            move_to_split ":.2" ":.1" "$(height_lhs_secondary_main)"
        fi
        case "${mode}" in
            "vert_even")
                even_vertical "${idx_rhs_start}" "${_n_panes}" 100
                if [ "${_n_panes}" -eq 2 ]; then
                    tmux resize-pane -t ":.1" -x "50%"
                fi
                ;;
            "vert_main")
                main_vertical "${idx_rhs_start}" "${_n_panes}" 67
                ;;
        esac
    fi
    set_vifm_miller "${IDX_PANE_MIN}"
}

main() {
    case "${1}" in
        "vert_even" | "vert_main")
            pipeline "${1}"
            ;;
        "vifm_miller")
            shift
            set_vifm_miller
            ;;
    esac
}
main "${@}"
unset -f main
