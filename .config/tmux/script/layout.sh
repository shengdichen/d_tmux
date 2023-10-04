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

function pipeline() {
    if [[ $(pane_command ":.1") == "vifm" ]]; then
        layout_default
        if [[ $(pane_command ":.2") == "zsh" ]]; then
            move_to_split ":.2" ":.1" "67%"
        fi
    fi
}

function main() {
    pipeline
}
main
unset -f main
