#!/usr/bin/env dash

pane_command() {
    tmux display-message -p -t "${1}" -F "#{pane_current_command}"
}

__size_of() {
    tmux display-message -p -t "${1}" -F "#{${2}_${3}}"
}

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

width_lhs_main() {
    local width_min=59 width_max=97
    local width_by_perc
    width_by_perc=$(($(__size_of ":" "window" "width") / 3))

    case "${1}" in
        "min")
            echo "${width_min}"
            ;;
        "max")
            echo "${width_max}"
            ;;
        "perc")
            echo "${width_by_perc}"
            ;;
        "range")
            __squeeze "${width_by_perc}" "${width_min}" "${width_max}"
            ;;
    esac
}

set_vifm_miller() {
    local _target=":.${1-}" _threshold=67
    if [ "$(pane_command "${_target}")" = "vifm" ]; then
        local _width
        _width="$(__size_of "${_target}" "pane" "width")"

        if [ "${_width}" -lt "${_threshold}" ]; then
            tmux send-keys -t "${_target}" ":set nomillerview" "Enter"
        else
            tmux send-keys -t "${_target}" ":set millerview" "Enter"
        fi
    fi
}

height_lhs_secondary_main() {
    local height_total height_primary
    height_total=$(__size_of ":" "window" "height")
    height_primary=$(__squeeze $((height_total / 3)) 20 53)

    echo $((height_total - height_primary))
}

layout_default() {
    tmux select-layout main-vertical

    tmux resize-pane -t ":.1" -x "$(width_lhs_main "range")"
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
    local n_panes
    n_panes=$(tmux display-message -p -t ":" -F "#{window_panes}")

    if [ "${n_panes}" -eq 2 ]; then
        tmux resize-pane -t ":.1" -x "50%"
        case "${mode}" in
            "vert_even")
                tmux select-layout even-vertical
                ;;
            "vert_main")
                layout_default
                ;;
        esac
    elif [ "$(pane_command ":.1")" = "vifm" ]; then
        layout_default
        local idx_rhs_start=2
        if [ "$(pane_command ":.2")" = "zsh" ]; then
            idx_rhs_start=3
            move_to_split ":.2" ":.1" "$(height_lhs_secondary_main)"
        fi
        case "${mode}" in
            "vert_even")
                even_vertical "${idx_rhs_start}" "${n_panes}" 100
                if [ "${n_panes}" -eq 2 ]; then
                    tmux resize-pane -t ":.1" -x "50%"
                fi
                ;;
            "vert_main")
                main_vertical "${idx_rhs_start}" "${n_panes}" 67
                ;;
        esac
    fi
    set_vifm_miller "1"
}

main() {
    case "${1}" in
        "vert_even" | "vert_main")
            pipeline "${1}"
            ;;
        "vifm_miller")
            set_vifm_miller
            ;;
    esac
}
main "${@}"
unset -f main
