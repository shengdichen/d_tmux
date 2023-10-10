session_path="${HOME}/.local/state/nvim/throw_session.vim"

function should_respawn() {
    [[ $(tmux display-message -p -F "#{pane_current_command}") == "vifm" ]]
}

function make_session() {
    tmux send-keys ":mksession! ${session_path} || qa" "Enter"
}

function respawn() {
    tmux split-window "nvim -S ${session_path}"
}

function main() {
    if should_respawn; then
        make_session
        respawn
    fi

    unset session_path
    unset -f should_respawn make_session respawn
}
main
unset -f main
