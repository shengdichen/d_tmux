function pane_command() {
    local target="${1}"
    tmux display-message -p -t "${target}" -F "#{pane_current_command}"
}

function layout_default() {
    tmux select-layout main-vertical
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
    local n_panes
    n_panes=$(tmux display-message -p -t ":" -F "#{window_panes}")

    if [[ "${n_panes}" -gt 1 ]]; then
        if [[ $(pane_command ":.1") == "vifm" ]]; then
            layout_default
            if [[ $(pane_command ":.2") == "zsh" ]]; then
                move_to_split ":.2" ":.1" "67%"
                even_vertical 3 "${n_panes}"
            else
                even_vertical 2 "${n_panes}"
            fi
        else
            even_vertical 1 "${n_panes}"
        fi
    fi
}

function main() {
    pipeline
}
main
unset -f main
