#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

. "./util.sh"

PATH_SESSION="${HOME}/.local/state/nvim/throw_session.vim"

__make_session() {
    tmux send-keys ":mksession! ${PATH_SESSION} || qa" "Enter"
}

__respawn() {
    tmux split-window "nvim -S ${PATH_SESSION}"
}

__main() {
    if [ "$(__pane_command)" = "vifm" ]; then
        __make_session
        __respawn
    fi
}
__main
