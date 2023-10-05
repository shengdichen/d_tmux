function pane_command() {
    local target="${1}"
    tmux display-message -p -t "${target}" -F "#{pane_current_command}"
}

function size_of() {
    local target="${1}"

    tmux display-message -p -t "${target}" -F "#{${2}_${3}}"
}

function __squeeze() {
    local val="${1}" min="${2}" max="${3}"
    if (( val < min )); then
        echo "${min}"
    elif (( val > max )); then
        echo "${max}"
    else
        echo "${val}"
    fi
}

function width_lhs_main() {
    local width_min=59 width_max=97
    local width_by_perc
    width_by_perc=$(( $(size_of ":" "window" "width") / 3 ))

    case "${1}" in
        "min" )
            echo "${width_min}"
            ;;
        "max" )
            echo "${width_max}"
            ;;
        "perc" )
            echo "${width_by_perc}"
            ;;
        "range" )
            __squeeze "${width_by_perc}" "${width_min}" "${width_max}"
            ;;
    esac
}

function set_vifm_miller() {
    local target=":.${1}" threshold=67
    if [[ $(pane_command "${target}") == "vifm" ]]; then
        local width
        width=$(size_of "${target}" "pane" "width")

        if (( width < threshold )); then
            tmux send-keys -t "${target}" ":set nomillerview" "Enter"
        else
            tmux send-keys -t "${target}" ":set millerview" "Enter"
        fi
    fi
}

function height_lhs_secondary_main() {
    local height_total height_primary
    height_total=$(size_of ":" "window" "height")
    height_primary=$(__squeeze $(( height_total / 3 )) 20 53)

    echo $(( height_total - height_primary ))
}

function layout_default() {
    tmux select-layout main-vertical

    tmux resize-pane -t ":.1" -x "$(width_lhs_main "range")"
}

function move_to_split() {
    local source="${1}" to_split="${2}" new_size="${3}"

    # -d := do NOT switch to source-pane
    tmux join-pane \
        -d \
        -s "${source}" \
        -t "${to_split}" \
        -l "${new_size}"
}

function even_vertical() {
    local start="${1}" end="${2}" full_size="${3}"

    if (( "${start}" < "${end}" )); then
        local n_panes size_avg size_last
        n_panes=$((end - start + 1))
        size_avg=$((full_size / n_panes))
        size_last=$((full_size - (n_panes - 1) * size_avg))

        for pane in $(seq "${start}" $((end - 1))); do
            tmux resize-pane -t ":.${pane}" -y "${size_avg}%"
        done
        tmux resize-pane -t ":.${end}" -y "${size_last}%"
    fi
}

function main_vertical() {
    local start="${1}" end="${2}" main_size="${3}"

    if (( "${start}" < "${end}" )); then
        tmux resize-pane -t ":.${start}" -y "${main_size}%"
        even_vertical $((start + 1)) "${end}" $((100 - main_size))
    fi
}

function pipeline() {
    local mode="${1}"
    local n_panes
    n_panes=$(tmux display-message -p -t ":" -F "#{window_panes}")

    if [[ $(pane_command ":.1") == "vifm" ]]; then
        layout_default
        local idx_rhs_start=2
        if [[ $(pane_command ":.2") == "zsh" ]]; then
            idx_rhs_start=3
            move_to_split ":.2" ":.1" "$(height_lhs_secondary_main)"
        fi
        case "${mode}" in
            "vert_even" )
                even_vertical "${idx_rhs_start}" "${n_panes}" 100
                if (( "${n_panes}" == 2 )); then
                    tmux resize-pane -t ":.1" -x "50%"
                fi
                ;;
            "vert_main" )
                main_vertical "${idx_rhs_start}" "${n_panes}" 67
                ;;
        esac
        set_vifm_miller "1"
    else
        case "${mode}" in
            "vert_even" )
                tmux select-layout even-vertical
                ;;
            "vert_main" )
                layout_default
                ;;
        esac
    fi
}

function main() {
    case "${1}" in
        "vert_even" | "vert_main" )
            pipeline "${1}"
            ;;
        "vifm_miller" )
            set_vifm_miller ""
            ;;
    esac
}
main "${@}"
unset -f main
