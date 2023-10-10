session_path="${HOME}/.local/state/nvim/throw_session.vim"

function make_session() {
    tmux send-keys ":mksession! ${session_path} || qa" "Enter"
}

function respawn() {
    tmux split-window "nvim -S ${session_path}"
}

function main() {
    make_session
    respawn

    unset session_path
    unset -f make_session respawn
}
main
unset -f main
