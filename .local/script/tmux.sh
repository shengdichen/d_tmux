#!/usr/bin/env dash

__tmux_running() {
    pgrep -u "$(id -u)" -f "^tmux .*start" 1>/dev/null
}

__tmux_start() {
    printf "tmux> launching...\n"
    tmux start-server
    "${HOME}/.config/tmux/script/task/sys.sh"
    "${HOME}/.config/tmux/script/task/dot.sh" --no-attach

    # so that there exists a history of attached sessions already
    tmux attach-session -t "=dot:=main" ";" attach-session -t "=sys:=mnt.3"
}

__tmux_attach_session() {
    if [ ! "${TMUX}" ]; then
        local _session
        _session="$(tmux list-sessions -F "#{session_name}" | fzf --reverse)"
        tmux attach-session -t "${_session}"
    else
        printf "tmux> already in tmux, done!\n"
    fi
}

__tmux_attach_window() {
    local _session _window _choice
    _choice="$(
        tmux list-sessions -F "#{session_name}" | while read -r _session; do
            tmux list-windows -t "${_session}" -F "#{window_name}" | while read -r _window; do
                printf "%s> %s\n" "${_session}" "${_window}"
            done
        done |
            fzf --reverse |
            sed "s/^\(.*\)> \(.*\)$/=\1:=\2/"
    )"
    # must first become a client before switching
    tmux attach-session ";" switch-client -t "${_choice}"
}

case "${1}" in
    "run")
        if ! __tmux_running; then
            __tmux_start
        else
            __tmux_attach_window
        fi
        ;;
    *) ;;
esac
